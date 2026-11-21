# Akash Gupta - Flutter Web Portfolio Application

A production-grade, responsive Web portfolio application built in **Flutter (Dart)** for **Akash Gupta** (Senior Flutter Developer, Mobile Architect, and IoT Specialist).

---

## 🌐 Platform Architecture
This application is written in Flutter and built specifically for the **Web**:
- 🌐 **Web** (Compiled with CanvasKit / HTML rendering)

---

## 🎨 Features & Implementation Highlights
- **Desktop/Web First**: Dedicated wide layout, permanent desktop navigation bar with direct scroll spy jumps.
- **Dynamic Theme Modes**:
  - **Executive Light**: Pristine Alabaster (`#F8FAFC`) + Executive Azure (`#0284C7`) and Deep Navy (`#0F172A`).
  - **Midnight Luxury**: Onyx (`#0D1117`) + Brushed Champagne Gold (`#E2C799`).
- **Smooth Navigation**: Custom `ScrollController` with `Scrollable.ensureVisible` for jumping between sections.
- **Dynamic Filtering**: Real-time project filter chips (*All, Flutter, IoT, FlutterFlow, QA & Cloud*).
- **Interactive Links**: Uses `url_launcher` for direct email (`mailto:`), phone (`tel:`), LinkedIn, and resume download.

---

## 🚀 How to Run the Web App

### Option 1: Live Web Preview (Pre-compiled)
The app is already compiled for the web in `build/web/`. To view it in your browser:
```bash
cd flutter_portfolio/build/web
python3 -m http.server 8080
```
Open [http://localhost:8080](http://localhost:8080) in Chrome, Safari, or Edge.

---

### Option 2: Run directly with Flutter CLI
To launch the Flutter web app in development:

```bash
cd flutter_portfolio
flutter run -d chrome
```

---

## 📂 Project Structure
```
flutter_portfolio/
├── lib/
│   └── main.dart            # Flutter Web Portfolio source code
├── assets/
│   └── Akash_Gupta_Resume.pdf
├── web/                     # Web runner files
├── build/web/               # Compiled release Web app
└── pubspec.yaml             # Dependencies and Flutter configuration
```
