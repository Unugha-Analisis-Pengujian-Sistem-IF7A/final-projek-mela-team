import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Notifikasi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildReminderCard(
              title: "Jangan sampai lupa,",
              subtitle: "hari ini jadwal pengumpulan iuran rutin",
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              title: "Terima kasih telah berkontribusi!",
              subtitle: "Status iuran Anda kini LUNAS.",
            ),
            const SizedBox(height: 16),
            _buildReminderCard(
              title: "Jangan sampai lupa,",
              subtitle: "hari ini jadwal pengumpulan iuran rutin",
            ),
            const SizedBox(height: 10),
            _buildInfoCard(
              title: "Terima kasih telah berkontribusi!",
              subtitle: "Status iuran Anda kini LUNAS.",
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Kartu biru (Pengingat)
  Widget _buildReminderCard({required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  // 🔹 Kartu putih (Ucapan)
  Widget _buildInfoCard({required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black87, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
