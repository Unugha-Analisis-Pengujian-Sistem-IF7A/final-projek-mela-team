import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:catatku/pages/laporan_pemasukan_page.dart';
import 'package:catatku/pages/edit_transaksi_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  group('LaporanPemasukanPage Widget Test', () {
    testWidgets('Menampilkan judul AppBar', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      expect(find.text('Laporan Data Pemasukan'), findsOneWidget);
    });

    testWidgets('Menampilkan filter Tahun dan Tanggal', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      expect(find.text('2025'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('Menampilkan header tabel', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      expect(find.text('Jenis'), findsOneWidget);
      expect(find.text('Kategori'), findsOneWidget);
      expect(find.text('Nominal'), findsOneWidget);
    });

    testWidgets('Menampilkan data pemasukan', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      expect(find.text('Konsumsi'), findsOneWidget);
      expect(find.text('Transport'), findsOneWidget);
      expect(find.text('Donasi'), findsOneWidget);
      expect(find.text('Lainnya'), findsOneWidget);
    });

    testWidgets('Jumlah data Masuk sesuai', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      expect(find.text('Masuk'), findsNWidgets(4));
    });

    testWidgets('Tombol edit membuka EditTransaksiPage', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      expect(find.byType(EditTransaksiPage), findsOneWidget);
    });

    testWidgets('Tombol hapus mengurangi jumlah data', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      expect(find.byIcon(Icons.delete), findsNWidgets(4));

      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pump();

      expect(find.byIcon(Icons.delete), findsNWidgets(3));
    });

    testWidgets('Dropdown tahun dapat dibuka', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      await tester.tap(find.text('2025'));
      await tester.pumpAndSettle();

      expect(find.text('2024'), findsOneWidget);
      expect(find.text('2026'), findsOneWidget);
    });

    testWidgets('DatePicker muncul saat ikon kalender ditekan', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(const LaporanPemasukanPage()),
      );

      await tester.tap(find.byIcon(Icons.calendar_today));
      await tester.pumpAndSettle();

      expect(find.byType(DatePickerDialog), findsOneWidget);
    });
  });
}
