import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_portfolio/main.dart';

void main() {
  testWidgets('Portfolio loads and displays name', (WidgetTester tester) async {
    await tester.pumpWidget(const AkashPortfolioApp());
    expect(find.text('Akash Gupta'), findsWidgets);
  });
}
