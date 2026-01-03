import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catatku/pages/laporan_anggota_page.dart';
import 'package:catatku/pages/laporan_pemasukan_anggota_page.dart';
import 'package:catatku/pages/laporan_pengeluaran_anggota_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget createTestWidget() {
    return const MaterialApp(home: LaporanAnggotaPage());
  }

  testWidgets('LaporanAnggotaPage tampil dengan benar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestWidget());

    // AppBar title
    expect(find.text('Laporan Kas Anggota'), findsOneWidget);

    // Tombol utama
    expect(find.text('Pemasukan'), findsOneWidget);
    expect(find.text('Pengeluaran'), findsOneWidget);

    // Judul riwayat
    expect(find.text('Riwayat Transaksi'), findsOneWidget);
  });

  testWidgets('Menampilkan daftar transaksi (mock data)', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(createTestWidget());

    // Karena mockTransactions = 6 item
    expect(find.text('Konsumsi'), findsNWidgets(6));
    expect(find.text('Rp. 100.000'), findsNWidgets(6));
  });

  testWidgets('Navigasi ke halaman Laporan Pemasukan Anggota', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const LaporanAnggotaPage(),
        routes: {'/pemasukan': (_) => const LaporanPemasukanAnggotaPage()},
      ),
    );

    await tester.tap(find.text('Pemasukan'));
    await tester.pumpAndSettle();

    expect(find.byType(LaporanPemasukanAnggotaPage), findsOneWidget);
  });

  testWidgets('Navigasi ke halaman Laporan Pengeluaran Anggota', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: const LaporanAnggotaPage(),
        routes: {'/pengeluaran': (_) => const LaporanPengeluaranAnggotaPage()},
      ),
    );

    await tester.tap(find.text('Pengeluaran'));
    await tester.pumpAndSettle();

    expect(find.byType(LaporanPengeluaranAnggotaPage), findsOneWidget);
  });
}
