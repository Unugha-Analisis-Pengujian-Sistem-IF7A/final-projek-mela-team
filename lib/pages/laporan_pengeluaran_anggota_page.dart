import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';

class LaporanPengeluaranAnggotaPage extends StatefulWidget {
  const LaporanPengeluaranAnggotaPage({super.key});

  @override
  State<LaporanPengeluaranAnggotaPage> createState() =>
      _LaporanPengeluaranAnggotaPageState();
}

class _LaporanPengeluaranAnggotaPageState
    extends State<LaporanPengeluaranAnggotaPage> {
  String selectedYear = '2025';
  DateTime selectedDate = DateTime.now();

  final List<Map<String, String>> pengeluaranList = [
    {"kategori": "Konsumsi", "nominal": "Rp 100.000"},
    {"kategori": "Transport", "nominal": "Rp 50.000"},
    {"kategori": "Belanja Harian", "nominal": "Rp 75.000"},
    {"kategori": "Hiburan", "nominal": "Rp 120.000"},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != selectedDate) {
      setState(() => selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: const Text(
          'Laporan Pengeluaran Anggota',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ================= FILTER =================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ================= TAHUN =================
                Container(
                  width: 160,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF389FC5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedYear,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Colors.white),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      items: ['2024', '2025', '2026']
                          .map(
                            (year) => DropdownMenuItem(
                              value: year,
                              child: Center(
                                child: Text(
                                  year,
                                  style:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedYear = value!),
                      selectedItemBuilder: (_) => ['2024', '2025', '2026']
                          .map(
                            (year) => Center(
                              child: Text(
                                year,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),

                // ================= TANGGAL (FIX OVERFLOW) =================
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: 160,
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF389FC5),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateFormat('dd MMMM').format(selectedDate),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= HEADER =================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Jenis',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Text(
                        'Kategori',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Nominal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ================= LIST =================
            Expanded(
              child: ListView.builder(
                itemCount: pengeluaranList.length,
                itemBuilder: (context, index) {
                  final item = pengeluaranList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Jenis
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: const [
                              Icon(Icons.circle,
                                  color: Colors.red, size: 10),
                              SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'Keluar',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Kategori
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Text(
                              item['kategori']!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                        // Nominal
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              item['nominal']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
