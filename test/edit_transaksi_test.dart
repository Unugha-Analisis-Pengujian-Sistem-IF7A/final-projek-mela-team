import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatku/pages/edit_transaksi_page.dart';

void main() {
  testWidgets(
    'EditTransaksiPage menampilkan data awal dengan benar',
    (WidgetTester tester) async {
      // Render halaman dengan data dummy
      await tester.pumpWidget(
        const MaterialApp(
          home: EditTransaksiPage(
            kategori: 'Konsumsi',
            nominal: '100000',
            tanggal: '27/03/2023',
          ),
        ),
      );

      // ===== APPBAR =====
      expect(find.text('Edit Transaksi'), findsOneWidget);

      // ===== LABEL FORM =====
      expect(find.text('Kategori'), findsOneWidget);
      expect(find.text('Nominal'), findsOneWidget);
      expect(find.text('Tanggal'), findsOneWidget);

      // ===== ISI AWAL FORM =====
      expect(find.text('Konsumsi'), findsOneWidget);
      expect(find.text('100000'), findsOneWidget);
      expect(find.text('27/03/2023'), findsOneWidget);

      // ===== TOMBOL =====
      expect(find.text('Update'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    },
  );

  testWidgets(
    'Validasi muncul jika form dikosongkan',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: EditTransaksiPage(
            kategori: '',
            nominal: '',
            tanggal: '',
          ),
        ),
      );

      // Tekan tombol update tanpa isi form
      await tester.tap(find.text('Update'));
      await tester.pump();

      // ===== VALIDASI =====
      expect(find.text('Kategori wajib diisi'), findsOneWidget);
      expect(find.text('Nominal wajib diisi'), findsOneWidget);
      expect(find.text('Tanggal wajib diisi'), findsOneWidget);
    },
  );
}
