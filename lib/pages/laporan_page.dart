// lib/pages/laporan_page.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../utils/app_colors.dart';
import 'edit_transaksi_page.dart'; // ✅ Tambahkan import ini
import 'laporan_pemasukan_page.dart';
import 'laporan_pengeluaran_page.dart';

class LaporanPage extends StatelessWidget {
  const LaporanPage({Key? key}) : super(key: key);

  List<Map<String, String>> _mockTransactions() => List.generate(6, (i) {
    return {
      'title': 'Konsumsi',
      'date': 'Sabtu, 27 Maret 2023',
      'amount': 'Rp. 100.000',
    };
  });

  @override
  Widget build(BuildContext context) {
    final tx = _mockTransactions();

    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        title: const Text('Laporan Kas'),
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 18),

          // ===== Tombol lingkaran Pemasukan & Pengeluaran =====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LaporanPemasukanPage(),
                      ),
                    );
                  },
                  child: _buildLargeCircle(
                    icon: LucideIcons.download,
                    label: 'Pemasukan',
                    amount: 'Rp. 800.000',
                    color: AppColors.green,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LaporanPengeluaranPage(),
                      ),
                    );
                  },
                  child: _buildLargeCircle(
                    icon: LucideIcons.upload,
                    label: 'Pengeluaran',
                    amount: 'Rp. 400.000',
                    color: AppColors.pink,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ===== Riwayat Transaksi =====
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
              decoration: BoxDecoration(
                color: AppColors.darkBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Riwayat Transaksi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ✅ List transaksi langsung tampil (tanpa container putih besar)
                  Expanded(
                    child: ListView.separated(
                      itemCount: tx.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = tx[index];
                        return _buildTransactionTile(
                          context,
                          title: item['title']!,
                          date: item['date']!,
                          amount: item['amount']!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ======================= Components =======================

  Widget _buildLargeCircle({
    required IconData icon,
    required String label,
    required String amount,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white.withOpacity(0.9),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(8),
                color: color,
              ),
              child: Center(child: Icon(icon, color: Colors.white, size: 30)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 4),
        Text(amount, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }

  // ===== Tile Transaksi (dengan ikon edit menuju EditTransaksiPage) =====
  Widget _buildTransactionTile(
    BuildContext context, {
    required String title,
    required String date,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.pink.withOpacity(0.4),
            child: const Icon(
              LucideIcons.wallet,
              color: Colors.black54,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),

              // ✅ Ikon edit menuju ke EditTransaksiPage dengan data transaksi
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => EditTransaksiPage(
                            kategori: title,
                            nominal: amount,
                            tanggal: date,
                          ),
                    ),
                  );
                },
                child: const Icon(
                  LucideIcons.edit3,
                  size: 18,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
