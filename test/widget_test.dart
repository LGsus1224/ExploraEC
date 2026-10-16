import 'dart:io';

import 'package:exploraec/main.dart';
import 'package:exploraec/services/settings_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

void main() {
  late Directory carpeta;

  setUp(() async {
    carpeta = await Directory.systemTemp.createTemp('exploraec_widget_test');
    Hive.init(carpeta.path);
    await Hive.openBox<Map>('favoritos');
    await SettingsService.abrir();
  });

  tearDown(() async {
    await Hive.close();
    await carpeta.delete(recursive: true);
  });

  testWidgets('Inicio muestra los lugares tras la carga simulada', (WidgetTester tester) async {
    await tester.pumpWidget(const ExploraEcApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Parque El Ejido'), findsOneWidget);
  });
}
