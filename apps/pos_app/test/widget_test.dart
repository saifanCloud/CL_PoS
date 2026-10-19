import 'package:flutter_test/flutter_test.dart';
import 'package:pos_app/main.dart';

void main() {
  testWidgets('POS Cashier smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PosApplication());

    // Verify that cashier screen loads with store header
    expect(find.text('CL PoS - Kasir'), findsOneWidget);
    expect(find.text('Keranjang masih kosong\nPilih menu untuk menambahkan'), findsOneWidget);
  });
}
