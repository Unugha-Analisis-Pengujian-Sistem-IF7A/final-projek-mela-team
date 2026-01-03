import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/custom_button.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF6FB), // warna background senada
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 230),
              const SizedBox(height: 40),
              const Text(
                'Hey there!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E6A7C), // sesuai tone aplikasi
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Ready to manage your organization's finances smarter and faster?\nLet's make bookkeeping easy with CatatKu!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 48),

              // Tombol disesuaikan style-nya agar senada
              CustomButton(
                text: 'Get Started',
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                backgroundColor: const Color(0xFF3E7386), // biru gelap senada
                textColor: Colors.white,
                radius: 30,
                shadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),
                    offset: const Offset(0, 6),
                    blurRadius: 12,
                  ),
                ],
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 42,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
