# Pawcation — Mobile App (Flutter / Dart)

Aplikasi mobile UI/UX **Pawcation** (Sanctuary, Pet Hotel, Konsultasi Dokter Hewan, Marketplace, Jadwal & Agenda Anabul, Live Cam, Pet Taxi, dan Rekam Medis) menggunakan **Flutter (Dart)** dengan data statis/dummy dan reusable widgets.

## Cara Menjalankan

1. Masuk ke folder proyek Flutter:
   ```bash
   cd flutter_app
   ```
2. Jika folder `android/`, `ios/`, atau `web/` belum dibuat pada mesin lokal Anda, jalankan:
   ```bash
   flutter create .
   ```
   *(Perintah ini akan membuat runner platform tanpa menimpa folder `lib/`, `assets/`, dan `pubspec.yaml`.)*
3. Unduh dependensi & daftarkan aset:
   ```bash
   flutter pub get
   ```
4. Jalankan di **Chrome** atau **Emulator Android/iOS**:
   ```bash
   flutter run -d chrome
   # atau pada emulator yang aktif:
   flutter run
   ```
