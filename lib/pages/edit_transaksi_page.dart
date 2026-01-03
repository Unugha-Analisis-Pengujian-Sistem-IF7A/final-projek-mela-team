import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';
import 'laporan_page.dart';

class EditTransaksiPage extends StatefulWidget {
  final String kategori;
  final String nominal;
  final String tanggal;

  const EditTransaksiPage({
    Key? key,
    required this.kategori,
    required this.nominal,
    required this.tanggal,
  }) : super(key: key);

  @override
  State<EditTransaksiPage> createState() => _EditTransaksiPageState();
}

class _EditTransaksiPageState extends State<EditTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kategoriController;
  late TextEditingController _nominalController;
  late TextEditingController _tanggalController;

  @override
  void initState() {
    super.initState();
    _kategoriController = TextEditingController(text: widget.kategori);
    _nominalController = TextEditingController(text: widget.nominal);
    _tanggalController = TextEditingController(text: widget.tanggal);
  }

  @override
  void dispose() {
    _kategoriController.dispose();
    _nominalController.dispose();
    _tanggalController.dispose();
    super.dispose();
  }

  void _updateTransaksi() {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();

      // ✅ Tampilkan notifikasi tengah (ala Shopee)
      _showFloatingNotification(context);

      // Setelah delay, kembali ke halaman laporan
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LaporanPage()),
        );
      });
    }
  }

  // 🔹 Fungsi menampilkan notifikasi tengah hitam nerawang
  void _showFloatingNotification(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).size.height * 0.45,
            left: MediaQuery.of(context).size.width * 0.2,
            right: MediaQuery.of(context).size.width * 0.2,
            child: Material(
              color: Colors.transparent,
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "✅ Transaksi berhasil diperbarui",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);

    // Hilangkan notifikasi setelah 2 detik
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  // 🔹 Pilih tanggal (seperti di halaman InputTransaksi)
  Future<void> _pilihTanggal() async {
    DateTime initialDate;
    try {
      initialDate = DateFormat('dd/MM/yyyy').parse(_tanggalController.text);
    } catch (_) {
      initialDate = DateTime.now();
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.darkBlue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _tanggalController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlue,
      appBar: AppBar(
        title: const Text("Edit Transaksi"),
        backgroundColor: AppColors.darkBlue,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ====== Kategori ======
              const Text(
                "Kategori",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _kategoriController,
                decoration: _inputDecoration(),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Kategori wajib diisi'
                            : null,
              ),
              const SizedBox(height: 18),

              // ====== Nominal ======
              const Text(
                "Nominal",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Nominal wajib diisi'
                            : null,
              ),
              const SizedBox(height: 18),

              // ====== Tanggal ======
              const Text(
                "Tanggal",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 6),
              TextFormField(
                controller: _tanggalController,
                readOnly: true,
                onTap: _pilihTanggal,
                decoration: _inputDecoration().copyWith(
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: Colors.black54,
                  ),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Tanggal wajib diisi'
                            : null,
              ),
              const SizedBox(height: 40),

              // ====== Tombol Update ======
              Center(
                child: ElevatedButton(
                  onPressed: _updateTransaksi,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 4,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 14,
                    ),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.9),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: AppColors.darkBlue, width: 1.6),
      ),
    );
  }
}
