import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatku/pages/notifikasi_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget(Widget child) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('NotifikasiPage tampil dengan AppBar dan judul',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(const NotifikasiPage()),
    );

    await tester.pumpAndSettle();

    // ✅ Judul AppBar
    expect(find.text('Notifikasi'), findsOneWidget);

    // ✅ AppBar ada
    expect(find.byType(AppBar), findsOneWidget);
  });

  testWidgets('Menampilkan kartu pengingat',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(const NotifikasiPage()),
    );

    await tester.pumpAndSettle();

    expect(find.text('Jangan sampai lupa,'), findsWidgets);
    expect(
      find.text('hari ini jadwal pengumpulan iuran rutin'),
      findsWidgets,
    );
  });

  testWidgets('Menampilkan kartu informasi',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      makeTestableWidget(const NotifikasiPage()),
    );

    await tester.pumpAndSettle();

    expect(
      find.text('Terima kasih telah berkontribusi!'),
      findsWidgets,
    );
    expect(
      find.text('Status iuran Anda kini LUNAS.'),
      findsWidgets,
    );
  });
}
