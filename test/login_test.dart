import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// SESUAIKAN DENGAN NAMA PROJECT
import 'package:catatku/pages/login_page.dart';
import 'package:catatku/pages/dashboard_page.dart';
import 'package:catatku/pages/dashboard_anggota_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('LoginPage tampil dengan komponen utama',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(const LoginPage()),
    );

    await tester.pumpAndSettle();

    // Judul
    expect(find.text('Catatku'), findsOneWidget);

    // Input field
    expect(find.byType(TextField), findsNWidgets(2));

    // Tombol Sign In
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Login berhasil sebagai bendahara',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(const LoginPage()),
    );

    await tester.pumpAndSettle();

    // Isi username
    await tester.enterText(
      find.byType(TextField).at(0),
      'bendahara',
    );

    // Isi password
    await tester.enterText(
      find.byType(TextField).at(1),
      '12345',
    );

    // Klik tombol Sign In
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    // Berhasil ke DashboardPage
    expect(find.byType(DashboardPage), findsOneWidget);
  });

  testWidgets('Login berhasil sebagai anggota',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(const LoginPage()),
    );

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).at(0),
      'anggota',
    );

    await tester.enterText(
      find.byType(TextField).at(1),
      '12345',
    );

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.byType(DashboardAnggotaPage), findsOneWidget);
  });

  testWidgets('Login gagal menampilkan SnackBar',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(const LoginPage()),
    );

    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).at(0),
      'salah',
    );

    await tester.enterText(
      find.byType(TextField).at(1),
      'salah',
    );

    await tester.tap(find.text('Sign In'));
    await tester.pump(); // penting untuk SnackBar

    expect(
      find.text('Username atau password salah'),
      findsOneWidget,
    );
  });
}
