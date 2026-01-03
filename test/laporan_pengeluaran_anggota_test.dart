import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// SESUAIKAN PATH DENGAN STRUKTUR PROJECT KAMU
import 'package:catatku/pages/laporan_pengeluaran_anggota_page.dart';

void main() {
  testWidgets(
    'LaporanPengeluaranAnggotaPage tampil dengan benar',
    (WidgetTester tester) async {
      // Render widget
      await tester.pumpWidget(
        const MaterialApp(
          home: LaporanPengeluaranAnggotaPage(),
        ),
      );

      // Biarkan animasi selesai
      await tester.pumpAndSettle();

      // ================= APPBAR =================
      expect(
        find.text('Laporan Pengeluaran Anggota'),
        findsOneWidget,
      );

      // ================= FILTER =================
      expect(find.text('2025'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);

      // ================= HEADER =================
      expect(find.text('Jenis'), findsOneWidget);
      expect(find.text('Kategori'), findsOneWidget);
      expect(find.text('Nominal'), findsOneWidget);

      // ================= LIST ITEM =================
      expect(find.text('Keluar'), findsWidgets);

      expect(find.text('Konsumsi'), findsOneWidget);
      expect(find.text('Transport'), findsOneWidget);
      expect(find.text('Belanja Harian'), findsOneWidget);
      expect(find.text('Hiburan'), findsOneWidget);

      expect(find.text('Rp 100.000'), findsOneWidget);
      expect(find.text('Rp 50.000'), findsOneWidget);
      expect(find.text('Rp 75.000'), findsOneWidget);
      expect(find.text('Rp 120.000'), findsOneWidget);
    },
  );
}
