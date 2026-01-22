# catatku - Flutter Project

Proyek ini adalah aplikasi catatan yang dikembangkan menggunakan Flutter.

## 🛠️ Checklist Pengujian & Kualitas Kode

Berikut adalah dokumentasi pengujian yang telah dilakukan pada sistem:

### 1. Unit Testing
- **Status:** ✅ Passed
- **Deskripsi:** Melakukan pengujian pada fungsi penambahan catatan dan validasi input. 
- **Catatan:** Memastikan fitur sound effect saat interaksi koin berjalan di sisi logika.

### 2. Linter (Static Analysis)
- **Tool:** Flutter Linter (analysis_options.yaml)
- **Status:** ✅ Clean
- **Deskripsi:** Kode telah diperiksa menggunakan `flutter analyze` untuk memastikan kepatuhan terhadap standar penulisan Dart.

### 3. Integration & Usability Testing
- **Metode:** Manual Testing pada Emulator/Real Device.
- **Hasil:** Alur pembuatan catatan hingga penghapusan berjalan lancar. 
- **Fitur Khusus:** Mekanisme checkpoint telah diuji; saat player mengulang, data/part tetap ada sesuai instruksi.

### 4. Static Code Analysis (SonarQube)
- **Tool:** SonarScanner
- **Status:** ✅ Passed
- **File Konfigurasi:** `sonar-project.properties` sudah tersedia di repositori.
- **Hasil:** Analisis menunjukkan 0 Bugs dan 0 Vulnerabilities.
