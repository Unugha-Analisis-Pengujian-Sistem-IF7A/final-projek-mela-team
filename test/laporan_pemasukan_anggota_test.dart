import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catatku/pages/laporan_pemasukan_anggota_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(home: child);
  }

  group('LaporanPemasukanAnggotaPage Widget Test', () {
    testWidgets('Menampilkan judul AppBar', (WidgetTester tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanAnggotaPage()),
      );

      expect(find.text('Laporan Pemasukan Anggota'), findsOneWidget);
    });

    testWidgets('Menampilkan filter Tahun dan Tanggal', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanAnggotaPage()),
      );

      // Tahun default
      expect(find.text('2025'), findsOneWidget);

      // Icon kalender
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('Menampilkan header tabel', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanAnggotaPage()),
      );

      expect(find.text('Jenis'), findsOneWidget);
      expect(find.text('Kategori'), findsOneWidget);
      expect(find.text('Nominal'), findsOneWidget);
    });

    testWidgets('Menampilkan daftar pemasukan', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanAnggotaPage()),
      );

      // Data kategori
      expect(find.text('Konsumsi'), findsOneWidget);
      expect(find.text('Transport'), findsOneWidget);
      expect(find.text('Donasi'), findsOneWidget);
      expect(find.text('Lainnya'), findsOneWidget);

      // Nominal
      expect(find.text('Rp 100.000'), findsOneWidget);
      expect(find.text('Rp 50.000'), findsOneWidget);
      expect(find.text('Rp 70.000'), findsOneWidget);
      expect(find.text('Rp 30.000'), findsOneWidget);
    });

    testWidgets('Menampilkan label Masuk di setiap item', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanAnggotaPage()),
      );

      // Ada 4 data → teks "Masuk" muncul 4 kali
      expect(find.text('Masuk'), findsNWidgets(4));
    });

    testWidgets('Dropdown tahun dapat dibuka', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanAnggotaPage()),
      );

      await tester.tap(find.text('2025'));
      await tester.pumpAndSettle();

      expect(find.text('2024'), findsOneWidget);
      expect(find.text('2026'), findsOneWidget);
    });

    testWidgets('DatePicker muncul saat tombol tanggal ditekan', (
      tester,
    ) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanAnggotaPage()),
      );

      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });
  });
}
