# 📱 Ario Sutrisno — Portfolio App

Aplikasi web & multiplatform portfolio interaktif berbasis **Flutter**, dirancang dengan estetika modern, performa tinggi, dan responsif penuh di semua perangkat.

---

## 📌 Ringkasan Portfolio

| Bagian | Deskripsi Singkat | Highlight / Tech |
| :--- | :--- | :--- |
| 🚀 **Hero & Direction** | Pengenalan profil, latar belakang operasional Garuda Indonesia, dan arah karier software engineering | Modern Typography, Custom Orbit Painter, Ambient Glow |
| 💼 **Selected Work** | Proyek nyata yang berfokus pada digitalisasi alur kerja operasional | **FSMS** (Laravel, MariaDB) & **Digital Ramp Checklist** (Flutter) |
| 🔬 **Learning Lab** | Studi konsep arsitektur data, AI workflow, dan sistem terintegrasi | Data Quality Review & Enterprise Integration |
| 🛠️ **Current Toolkit** | Stack teknologi & workflow pengembangan yang digunakan secara jujur | Flutter, Laravel, MySQL/MariaDB, Codex & AI Pairing |
| 📄 **Curriculum Vitae** | Halaman CV bertema *Clean White Paper* yang elegan, jernih, dan nyaman dibaca | Glassmorphism, Interactive Pills, Auto Clipboard Copy |
| 📬 **Contact & Socials** | Akses komunikasi langsung dan jejaring profesional | Email direct copy, LinkedIn, & GitHub links |

---

## 🛠️ Tech Stack & Architecture

| Kategori | Teknologi / Library |
| :--- | :--- |
| **Framework** | [Flutter 3.x](https://flutter.dev) (Dart SDK) |
| **Design System** | Custom Token System (`app_colors`, `app_tokens`, `app_typography`, `app_effects`) |
| **Responsive Engine** | Multi-breakpoint Logical Widths (320px → 2560px+) |
| **Target Platform** | Web (GitHub Pages), Android, iOS, Windows, macOS, Linux |

---

## 📂 Struktur Modul

```text
lib/portofolio/
├── core/                  # Design tokens, responsive helpers, & reusable widgets
│   ├── responsive/        # Breakpoints & adaptive layout system
│   ├── theme/             # Color palette, typography, & gradients
│   └── widgets/           # AppShell, AppReveal, & Identity marks
└── features/              # Feature screens
    ├── portfolio/         # Landing page & section views
    ├── resume/            # Elegant White-Paper CV screen
    └── case_study/        # Detailed project & concept case studies
```

---

## 🧪 Validasi & Testing

```sh
# Analisis kode & standard linter
dart analyze lib/portofolio

# Menjalankan unit & widget test
flutter test
```
