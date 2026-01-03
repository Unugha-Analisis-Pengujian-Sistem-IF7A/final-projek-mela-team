import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatku/pages/get_started_page.dart';

void main() {
  testWidgets('GetStartedPage tampil dan tombol berfungsi',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/login': (_) => const Scaffold(
                body: Text('Login Page'),
              ),
        },
        home: const GetStartedPage(),
      ),
    );

    // 🔹 Cek teks utama
    expect(find.text('Hey there!'), findsOneWidget);

    // 🔹 Cek deskripsi
    expect(
      find.textContaining("Ready to manage your organization's finances"),
      findsOneWidget,
    );

    // 🔹 Cek tombol
    final getStartedButton = find.text('Get Started');
    expect(getStartedButton, findsOneWidget);

    // 🔹 Tap tombol
    await tester.tap(getStartedButton);
    await tester.pumpAndSettle();

    // 🔹 Pastikan pindah ke Login Page
    expect(find.text('Login Page'), findsOneWidget);
  });
}
