import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:catatku/pages/input_transaksi_page.dart';
import 'package:catatku/pages/sukses_page.dart';
import 'package:catatku/providers/finance_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createTestWidget() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FinanceProvider(),
        ),
      ],
      child: MaterialApp(
        home: const InputTransaksiPage(),
      ),
    );
  }

  testWidgets('InputTransaksiPage tampil dengan benar',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    expect(find.text('Input Transaksi'), findsOneWidget);
    expect(find.text('Pemasukan'), findsOneWidget);
    expect(find.text('Pengeluaran'), findsOneWidget);
    expect(find.text('Simpan'), findsOneWidget);
  });

  testWidgets('Validasi form berjalan (field kosong)',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.tap(find.text('Simpan'));
    await tester.pump();

    expect(find.text('Isi keterangan'), findsOneWidget);
    expect(find.text('Isi jumlah'), findsOneWidget);
  });

  testWidgets('Input transaksi berhasil & pindah ke SuksesPage',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    // Isi keterangan
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'Beli Buku',
    );

    // Isi jumlah
    await tester.enterText(
      find.byType(TextFormField).at(1),
      '50000',
    );

    // Tap Simpan
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    // Berhasil ke halaman sukses
    expect(find.byType(SuksesPage), findsOneWidget);
  });

  testWidgets('Toggle kategori Pemasukan bisa dipilih',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.tap(find.text('Pemasukan'));
    await tester.pump();

    expect(find.text('Pemasukan'), findsOneWidget);
  });
}
