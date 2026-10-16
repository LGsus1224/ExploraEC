import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:exploraec/controllers/auth_controller.dart';
import 'package:exploraec/controllers/gastos_controller.dart';
import 'package:exploraec/screens/gastos_screen.dart';
import 'package:exploraec/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

/// Backend de gastos falso con tres gastos en dos categorías.
class _Backend implements HttpClientAdapter {
  static var _usuarios = 100;
  final idUsuario = ++_usuarios;
  final gastos = [
    {
      'id': 1,
      'descripcion': 'Almuerzo en el mercado',
      'monto': 6.5,
      'categoria': 'comida',
      'fecha': '2026-10-08'
    },
    {
      'id': 2,
      'descripcion': 'Taxi al terminal',
      'monto': 3.25,
      'categoria': 'transporte',
      'fecha': '2026-10-08'
    },
    {
      'id': 3,
      'descripcion': 'Cena en el centro',
      'monto': 12.0,
      'categoria': 'comida',
      'fecha': '2026-10-08'
    },
  ];

  ResponseBody _json(Object cuerpo, int codigo,
          [Map<String, List<String>> h = const {}]) =>
      ResponseBody.fromString(jsonEncode(cuerpo), codigo, headers: {
        Headers.contentTypeHeader: ['application/json'],
        ...h
      });

  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<Uint8List>? cuerpo,
      Future<void>? cancelar) async {
    switch (o.path) {
      case '/usuarios/token':
        return _json(
            {'access_token': 'tok-a@b.com', 'token_type': 'bearer'}, 200);
      case '/usuarios/me':
        return _json({'id': idUsuario, 'email': 'a@b.com'}, 200);
      case '/gastos/categorias':
        return _json({
          'categorias': ['comida', 'transporte', 'entretenimiento', 'otros'],
          'limite_por_categoria': 500.0
        }, 200);
      case '/gastos/':
        return _json(gastos, 200, {
          'x-total-count': ['${gastos.length}']
        });
    }
    return _json({'detail': 'ruta no prevista en la prueba: ${o.path}'}, 404);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  setUpAll(
      () => Hive.init(Directory.systemTemp.createTempSync('hive_filtro').path));

  Future<void> esperarRed(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 40)));
      await tester.pump(const Duration(milliseconds: 40));
    }
  }

  Future<void> abrirGastos(WidgetTester tester) async {
    await tester.runAsync(() async {
      Get.reset();
      Get.testMode = true;
      FlutterSecureStorage.setMockInitialValues({});
      final api = Get.put(ApiClient(
          dio: Dio(BaseOptions(baseUrl: 'http://backend'))
            ..httpClientAdapter = _Backend()));
      final auth = Get.put(AuthController());
      await auth.iniciarSesion('a@b.com', 'clave-1234');
      Get.put(GastosController());
      expect(api.token, isNotNull);
    });
    await tester.pumpWidget(const GetMaterialApp(home: GastosScreen()));
    await esperarRed(tester);
  }

  testWidgets('Al elegir «comida», solo se ven los gastos de comida',
      (tester) async {
    await abrirGastos(tester);
    expect(find.text('Almuerzo en el mercado'), findsOneWidget);
    expect(find.text('Taxi al terminal'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'comida'));
    await tester.pump();

    expect(find.text('Almuerzo en el mercado'), findsOneWidget);
    expect(find.text('Cena en el centro'), findsOneWidget);
    expect(find.text('Taxi al terminal'), findsNothing);
  });

  testWidgets('«Todas» vuelve a mostrar la lista completa', (tester) async {
    await abrirGastos(tester);
    await tester.tap(find.widgetWithText(ChoiceChip, 'transporte'));
    await tester.pump();
    expect(find.text('Almuerzo en el mercado'), findsNothing);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Todas'));
    await tester.pump();

    expect(find.text('Almuerzo en el mercado'), findsOneWidget);
    expect(find.text('Taxi al terminal'), findsOneWidget);
    expect(find.text('Cena en el centro'), findsOneWidget);
  });
}
