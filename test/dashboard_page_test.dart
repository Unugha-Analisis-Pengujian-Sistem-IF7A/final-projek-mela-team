import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatku/pages/dashboard_page.dart';

void main() {
  testWidgets(
    'Dashboard Bendahara menampilkan elemen utama dengan benar',
    (WidgetTester tester) async {
      // Bungkus dengan MaterialApp agar Navigator aman
      await tester.pumpWidget(
        const MaterialApp(
          home: DashboardPage(),
        ),
      );

      // ================= HEADER =================
      expect(find.text('Catatku'), findsOneWidget);

      // ================= PROFIL =================
      expect(find.text('Hellen'), findsOneWidget);
      expect(find.text('Bendahara'), findsOneWidget);
      expect(find.text('BEM IF'), findsOneWidget);

      // ================= SALDO =================
      expect(find.text('Sisa Kas'), findsOneWidget);
      expect(find.text('Rp. 4.800.000'), findsOneWidget);

      // ================= PEMASUKAN =================
      expect(find.text('Pemasukan'), findsOneWidget);
      expect(find.text('Rp. 800.000'), findsOneWidget);

      // ================= PENGELUARAN =================
      expect(find.text('Pengeluaran'), findsOneWidget);
      expect(find.text('Rp. 400.000'), findsOneWidget);

      // ================= RIWAYAT =================
      expect(find.text('Riwayat Transaksi'), findsOneWidget);
      expect(find.text('Lihat Semua >'), findsOneWidget);

      // ================= TRANSAKSI =================
      expect(find.text('Konsumsi'), findsOneWidget);
      expect(find.text('Bensin'), findsOneWidget);
      expect(find.text('Transportasi'), findsOneWidget);

      // ================= ICON =================
      // Ada icon edit
      expect(find.byIcon(Icons.edit), findsNothing); // bukan material icon
      expect(find.byType(GestureDetector), findsWidgets);

      // Ada icon wallet
      expect(find.byType(CircleAvatar), findsWidgets);
    },
  );
}
