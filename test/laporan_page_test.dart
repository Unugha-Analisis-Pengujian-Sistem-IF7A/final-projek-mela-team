import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:catatku/pages/laporan_page.dart';
import 'package:catatku/pages/edit_transaksi_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  group('LaporanPage Widget Test', () {
    testWidgets('Menampilkan judul Laporan Kas', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LaporanPage()));

      expect(find.text('Laporan Kas'), findsOneWidget);
    });

    testWidgets('Menampilkan tombol Pemasukan dan Pengeluaran', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LaporanPage()));

      expect(find.text('Pemasukan'), findsOneWidget);
      expect(find.text('Pengeluaran'), findsOneWidget);
    });

    testWidgets('Menampilkan daftar riwayat transaksi', (tester) async {
      await tester.pumpWidget(makeTestableWidget(const LaporanPage()));

      // Karena mockTransactions = 6
      expect(find.text('Konsumsi'), findsWidgets);
      expect(find.text('Rp. 100.000'), findsWidgets);
    });

    testWidgets('Navigasi ke EditTransaksiPage saat ikon edit ditekan', (
      tester,
    ) async {
      await tester.pumpWidget(makeTestableWidget(const LaporanPage()));

      // ✅ FIX UTAMA: gunakan LucideIcons.edit3
      final editIcon = find.byIcon(LucideIcons.edit3).first;
      expect(editIcon, findsOneWidget);

      await tester.tap(editIcon);
      await tester.pumpAndSettle();

      // Pastikan berpindah halaman
      expect(find.byType(EditTransaksiPage), findsOneWidget);
      expect(find.text('Edit Transaksi'), findsOneWidget);
    });
  });
}
