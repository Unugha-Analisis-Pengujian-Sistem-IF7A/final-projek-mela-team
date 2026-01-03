import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatku/pages/dashboard_anggota_page.dart';

void main() {
  testWidgets('Dashboard Anggota menampilkan elemen utama dengan benar', (
    WidgetTester tester,
  ) async {
    // Jalankan halaman dengan MaterialApp (WAJIB untuk Navigator)
    await tester.pumpWidget(const MaterialApp(home: DashboardAnggotaPage()));

    // ===== HEADER =====
    expect(find.text('Catatku'), findsOneWidget);
    expect(
      find.byIcon(Icons.notifications),
      findsNothing,
    ); // bukan Material icon

    // ===== PROFIL =====
    expect(find.text('Hellen'), findsOneWidget);
    expect(find.text('Anggota'), findsOneWidget);
    expect(find.text('BEM IF'), findsOneWidget);

    // ===== SALDO =====
    expect(find.text('Sisa Kas'), findsOneWidget);
    expect(find.text('Rp. 4.800.000'), findsOneWidget);

    // ===== PEMASUKAN & PENGELUARAN =====
    expect(find.text('Pemasukan'), findsOneWidget);
    expect(find.text('Rp. 800.000'), findsOneWidget);

    expect(find.text('Pengeluaran'), findsOneWidget);
    expect(find.text('Rp. 400.000'), findsOneWidget);

    // ===== RIWAYAT =====
    expect(find.text('Riwayat Transaksi'), findsOneWidget);
    expect(find.text('Lihat Semua >'), findsOneWidget);

    // ===== TRANSAKSI =====
    expect(find.text('Konsumsi'), findsOneWidget);
    expect(find.text('Bensin'), findsOneWidget);
    expect(find.text('Transportasi'), findsOneWidget);

    // Pastikan ada minimal 1 icon wallet
    expect(find.byType(CircleAvatar), findsWidgets);
  });
}
