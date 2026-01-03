import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatku/main.dart';

void main() {
  testWidgets('Catatku app loads correctly', (WidgetTester tester) async {
    // Jalankan aplikasi
    await tester.pumpWidget(const CatatkuApp());

    // Pastikan MaterialApp ada
    expect(find.byType(MaterialApp), findsOneWidget);

    // Pastikan teks Catatku tampil
    expect(find.text('Catatku'), findsOneWidget);

    // Alternatif aman pakai Key
    expect(find.byKey(const Key('titleText')), findsOneWidget);
  });
}
