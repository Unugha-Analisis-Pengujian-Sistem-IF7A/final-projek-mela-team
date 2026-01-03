import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatku/pages/sukses_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Helper agar ada Material & Navigator
  Widget makeTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  testWidgets('SuksesPage tampil dengan icon dan teks', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(makeTestableWidget(const SuksesPage()));

    await tester.pumpAndSettle();

    // ✅ Icon sukses
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    // ✅ Teks utama
    expect(find.text('Transaksi Berhasil!'), findsOneWidget);

    // ✅ Teks deskripsi
    expect(
      find.text('Data transaksi telah berhasil tercatat.'),
      findsOneWidget,
    );
  });

  testWidgets('SuksesPage memiliki tombol TUTUP', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(const SuksesPage()));

    await tester.pumpAndSettle();

    // ✅ Tombol TUTUP ada
    expect(find.text('TUTUP'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Tombol TUTUP bisa ditekan tanpa error', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: const Scaffold(body: SuksesPage())),
    );

    await tester.pumpAndSettle();

    // Tekan tombol
    await tester.tap(find.text('TUTUP'));
    await tester.pumpAndSettle();

    // ✅ Jika tidak crash, test dianggap lolos
    expect(true, isTrue);
  });
}
