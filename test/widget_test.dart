import 'package:flutter_test/flutter_test.dart';
import 'package:foodiego_app/main.dart' as app;

void main() {
  testWidgets('FoodieGoo smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    expect(find.byType(app.FoodieGooApp), findsOneWidget);
  });
}