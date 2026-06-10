import 'package:flutter_test/flutter_test.dart';
import 'package:foodiego_app/main.dart';

void main() {
  testWidgets('FoodieGoo smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodieGooApp());
    expect(find.text('FoodieGoo'), findsOneWidget);
  });
}