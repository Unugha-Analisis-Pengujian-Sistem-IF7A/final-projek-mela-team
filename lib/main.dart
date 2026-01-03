// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/get_started_page.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/input_transaksi_page.dart';
import 'pages/sukses_page.dart';
import 'providers/finance_provider.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CatatkuApp());
}

class CatatkuApp extends StatelessWidget {
  const CatatkuApp({super.key});

  @override
  Widget build(BuildContext context) {
    // <- Provider diletakkan DI SINI, di atas MaterialApp
    return ChangeNotifierProvider<FinanceProvider>(
      create: (_) => FinanceProvider(),
      child: MaterialApp(
        title: 'Catatku',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
        ),
        initialRoute: '/get-started',
        routes: {
          '/get-started': (_) => const GetStartedPage(),
          '/login': (_) => const LoginPage(),
          '/dashboard': (_) => const DashboardPage(),
          '/input': (_) => const InputTransaksiPage(),
          '/sukses': (_) => const SuksesPage(),
          // tambahkan route lain bila perlu
        },
      ),
    );
  }
}