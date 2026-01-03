import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// SESUAIKAN PATH PACKAGE DENGAN NAMA PROJECT DI pubspec.yaml
import 'package:catatku/pages/laporan_pengeluaran_page.dart';

void main() {
  testWidgets(
    'LaporanPengeluaranPage tampil dengan benar',
    (WidgetTester tester) async {
      // Render widget dengan MaterialApp
      await tester.pumpWidget(
        const MaterialApp(
          home: LaporanPengeluaranPage(),
        ),
      );

      // Tunggu semua animasi & frame selesai
      await tester.pumpAndSettle();

      // ================= APP BAR =================
      expect(
        find.text('Laporan Data Pengeluaran'),
        findsOneWidget,
      );

      // ================= FILTER =================
      expect(find.text('2025'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);

      // ================= HEADER =================
      expect(find.text('Jenis'), findsOneWidget);
      expect(find.text('Kategori'), findsOneWidget);
      expect(find.text('Nominal'), findsOneWidget);

      // ================= LIST DATA =================
      expect(find.text('Keluar'), findsWidgets);

      expect(find.text('Konsumsi'), findsOneWidget);
      expect(find.text('Transportasi'), findsOneWidget);
      expect(find.text('Belanja Harian'), findsOneWidget);
      expect(find.text('Hiburan'), findsOneWidget);

      expect(find.text('Rp 100.000'), findsOneWidget);
      expect(find.text('Rp 50.000'), findsOneWidget);
      expect(find.text('Rp 75.000'), findsOneWidget);
      expect(find.text('Rp 120.000'), findsOneWidget);

      // ================= ICON ACTION =================
      expect(find.byIcon(Icons.edit), findsWidgets);
      expect(find.byIcon(Icons.delete), findsWidgets);
    },
  );
}
