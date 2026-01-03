import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'package:intl/intl.dart';

class LaporanPemasukanAnggotaPage extends StatefulWidget {
  const LaporanPemasukanAnggotaPage({Key? key}) : super(key: key);

  @override
  State<LaporanPemasukanAnggotaPage> createState() =>
      _LaporanPemasukanAnggotaPageState();
}

class _LaporanPemasukanAnggotaPageState
    extends State<LaporanPemasukanAnggotaPage> {
  String selectedYear = '2025';
  DateTime selectedDate = DateTime.now();

  List<Map<String, String>> pemasukanList = [
    {"jenis": "Masuk", "kategori": "Konsumsi", "nominal": "Rp 100.000"},
    {"jenis": "Masuk", "kategori": "Transport", "nominal": "Rp 50.000"},
    {"jenis": "Masuk", "kategori": "Donasi", "nominal": "Rp 70.000"},
    {"jenis": "Masuk", "kategori": "Lainnya", "nominal": "Rp 30.000"},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue,
        title: const Text(
          'Laporan Pemasukan Anggota',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // =========================== FILTER ===========================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Tombol Tahun
                Container(
                  width: 160,
                  height: 45,
                  decoration: BoxDecoration(
                    color: const Color(0xFF389FC5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedYear,
                      dropdownColor: Colors.white,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      isExpanded: true,
                      alignment: Alignment.center,
                      items:
                          ['2024', '2025', '2026']
                              .map(
                                (year) => DropdownMenuItem(
                                  value: year,
                                  child: Center(
                                    child: Text(
                                      year,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value!;
                        });
                      },
                      selectedItemBuilder: (context) {
                        return ['2024', '2025', '2026'].map((year) {
                          return Center(
                            child: Text(
                              year,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ),

                // Tombol Tanggal
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFF389FC5),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(2, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            '${selectedDate.day} ${_monthName(selectedDate.month)}',
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
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // =========================== HEADER ===========================
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: const Offset(2, 3),
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

            // =========================== LIST ===========================
            Expanded(
              child: ListView.builder(
                itemCount: pemasukanList.length,
                itemBuilder: (context, index) {
                  var item = pemasukanList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: const Offset(2, 3),
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
                              Icon(Icons.circle, color: Colors.green, size: 10),
                              SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'Masuk',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.green,
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
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ),
                        ),

                        // Nominal (tanpa icon edit/hapus)
                        Expanded(
                          flex: 3,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              item['nominal']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.green,
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

  String _monthName(int month) {
    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return bulan[month - 1];
  }
}
