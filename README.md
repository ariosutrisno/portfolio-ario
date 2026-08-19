# 🌐 Ario Sutrisno — Interactive Portfolio

[![Live Demo](https://img.shields.io/badge/Live%20Demo-GitHub%20Pages-brightgreen?style=for-the-badge&logo=github)](https://ariosutrisno.github.io/portfolio-ario/)

Aplikasi portfolio digital interaktif berbasis **Flutter Web & Multiplatform**. Menggabungkan pengalaman operasional maskapai Garuda Indonesia dengan pengembangan perangkat lunak modern, UI responsif, dan kurikulum vitae interaktif.

---


## ⚙️ Cara Kerja Aplikasi

Aplikasi ini dibangun menggunakan arsitektur modular Flutter dengan prinsip desain token dan *fluid responsiveness*:

1. **Sistem Responsif Adaptif (All-Device Ready)**
   - Menggunakan kalkulasi piksel logis yang dikelompokkan ke 6 tingkatan breakpoint (`tiny` 320px, `compact` 680px, `medium` 1000px, `expanded` 1240px, `large` 1440px, `ultraWide` 2560px+).
   - Menyesuaikan tata letak grid, ukuran tipografi (*fluid scale*), gutter, dan navigasi (Header desktop ↔ Mobile drawer) secara otomatis tanpa jeda render.
   - Presisi di semua perangkat: HP Android kecil, iPhone (SE/Pro/Max), iPad/Tablet, Laptop, Monitor Full HD hingga Ultra-wide 4K.

2. **Navigasi & State Management**
   - **One-Page Navigation**: Menggunakan `Scrollable.ensureVisible` dengan animasi kurva halus (`easeInOutCubic`) untuk melompat antar seksi (Work, Expertise, Journey, About, Contact).
   - **Sub-pages**: Routing mulus ke halaman **Case Study** dan **Curriculum Vitae (Clean White-Paper Mode)**.

3. **Design System Mandiri**
   - Warna, gradasi, tipografi (DM Sans & Manrope), bayangan, dan radius terpusat di `lib/portofolio/core/theme/`.
   - Mengadopsi kontras tinggi, anti-glare, dan aksen warna hidup yang nyaman di mata pembaca.

---

## 🚀 Panduan Menjalankan di Lokal (Local Development)

### 1. Prasyarat
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (versi 3.24 atau lebih baru)
- Browser Chrome / Edge atau Emulator Android/iOS

### 2. Langkah Instalasi & Menjalankan

```sh
# 1. Clone repository
git clone https://github.com/ariosutrisno/portfolio-ario.git
cd portfolio-ario/portfolio

# 2. Ambil dependensi
flutter pub get

# 3. Validasi kode
dart analyze lib/portofolio
flutter test

# 4. Jalankan aplikasi di browser (Hot Reload aktif)
flutter run -d chrome
```

---

## 📦 Build & Deployment (GitHub Pages)

Aplikasi ini sudah terintegrasi dengan **GitHub Actions** (`.github/workflows/deploy.yml`) untuk build dan deploy otomatis ke GitHub Pages saat push ke branch `main`.

Untuk melakukan build manual:

```sh
cd portfolio
flutter build web --release --base-href "/portfolio-ario/"
```

Hasil build bundle produksi akan berada di folder `portfolio/build/web/`.
