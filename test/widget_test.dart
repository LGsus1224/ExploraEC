import 'package:flutter_test/flutter_test.dart';

import 'package:exploraec/main.dart';

void main() {
  testWidgets('Inicio muestra los lugares tras la carga simulada', (WidgetTester tester) async {
    await tester.pumpWidget(const ExploraEcApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Parque El Ejido'), findsOneWidget);
  });
}
