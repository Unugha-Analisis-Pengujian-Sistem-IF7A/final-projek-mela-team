import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';
import '../providers/finance_provider.dart';
import '../utils/app_colors.dart';
import 'sukses_page.dart';

class InputTransaksiPage extends StatefulWidget {
  const InputTransaksiPage({Key? key}) : super(key: key);

  @override
  State<InputTransaksiPage> createState() => _InputTransaksiPageState();
}

class _InputTransaksiPageState extends State<InputTransaksiPage> {
  final _formKey = GlobalKey<FormState>();
  final _descCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _category = 'Pengeluaran';

  @override
  void dispose() {
    _descCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final d = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (d != null) setState(() => _selectedDate = d);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final amountRaw =
        double.tryParse(_amountCtrl.text.replaceAll(',', '').trim()) ?? 0.0;
    final amount =
        _category == 'Pemasukan' ? amountRaw.abs() : -amountRaw.abs();

    final tx = TransactionModel(
      id: const Uuid().v4(),
      description: _descCtrl.text.trim(),
      amount: amount,
      date: _selectedDate,
      category: _category,
    );

    Provider.of<FinanceProvider>(context, listen: false).addTransaction(tx);

    _descCtrl.clear();
    _amountCtrl.clear();
    setState(() {
      _selectedDate = DateTime.now();
      _category = 'Pengeluaran';
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SuksesPage()),
    );
  }

  Widget _buildToggleButton(
    String label,
    IconData icon,
    bool active,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF5C9BB0) : const Color(0xFFE6F7FB),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(active ? 0.25 : 0.12),
              offset: Offset(active ? 2 : 1, active ? 4 : 2),
              blurRadius: active ? 6 : 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: active ? Colors.white : const Color(0xFF2E6A7C),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: active ? Colors.white : const Color(0xFF2E6A7C),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRaisedField({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 6),
            blurRadius: 12,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFF6FB),
      appBar: AppBar(
        backgroundColor: AppColors.darkBlue, // 🔹 Sama dengan edit_transaksi
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Input Transaksi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔸 Tetap warna lama (tidak diubah)
            Row(
              children: [
                _buildToggleButton(
                  'Pemasukan',
                  Icons.arrow_circle_up,
                  _category == 'Pemasukan',
                  () => setState(() => _category = 'Pemasukan'),
                ),
                _buildToggleButton(
                  'Pengeluaran',
                  Icons.arrow_circle_down,
                  _category == 'Pengeluaran',
                  () => setState(() => _category = 'Pengeluaran'),
                ),
              ],
            ),

            const SizedBox(height: 18),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const Text(
                      'Keterangan',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    _buildRaisedField(
                      child: TextFormField(
                        controller: _descCtrl,
                        decoration: const InputDecoration(
                          hintText: '',
                          border: InputBorder.none,
                        ),
                        validator:
                            (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Isi keterangan'
                                    : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Jumlah',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    _buildRaisedField(
                      child: TextFormField(
                        controller: _amountCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          hintText: '',
                          border: InputBorder.none,
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) {
                            return 'Isi jumlah';
                          }
                          final parsed = double.tryParse(
                            v.replaceAll(',', '').trim(),
                          );
                          if (parsed == null || parsed <= 0) {
                            return 'Masukkan angka yang valid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tanggal',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _pickDate,
                      child: _buildRaisedField(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                style: const TextStyle(fontSize: 16),
                              ),
                              const Icon(Icons.calendar_today, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // 🔹 Tombol "Simpan" disamakan dengan EditTransaksi
                    Center(
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkBlue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 56,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
