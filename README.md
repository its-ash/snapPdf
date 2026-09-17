# SnapPDF

A fast, fully offline document scanner and PDF creator for Android. Built with Flutter.

## Features

- **Camera capture** with automatic edge detection and perspective correction (Google ML Kit Document Scanner)
- **Filters** — Original, Magic Color, Black & White, Grayscale, Strong Contrast
- **Manual rotate** and page reordering
- **Multi-page documents** — scan, add, reorder, or delete pages before export
- **OCR** — on-device text extraction (Google ML Kit Text Recognition)
- **PDF export** — A4, Letter, or Legal page size
- **Password protection** — AES-256 encryption on exported PDFs
- **Share & print** straight from the document viewer
- **Dark mode**, fully offline, no accounts

## Architecture

Clean Architecture, three layers under `lib/`:

- `domain/` — entities (`ScanDocument`, `ScanPage`) and the `DocumentRepository` interface
- `data/` — datasources wrapping each external package (scanner, OCR, image processing, PDF, storage) and the repository implementation
- `presentation/` — Riverpod providers, screens, and shared widgets
- `core/` — constants, typed exceptions, and the app router

State management: [Riverpod](https://riverpod.dev). Design system: shared [`theme`](https://github.com/its-ash/theme) package.

See [.github/copilot-instructions.md](.github/copilot-instructions.md) for full conventions.

## Getting started

```bash
flutter pub get
flutter run
```

Requires Flutter 3.44+ and Dart 3.12+. Minimum platform support: Android 6.0 (API 23).

## Makefile

```bash
make run      # flutter run
make build    # release build for Android
make deploy   # build, bump version, tag, push, and cut a GitHub release
```

## Tech stack

| Component | Package |
|---|---|
| Camera / scanning | `camera`, `google_mlkit_document_scanner` |
| OCR | `google_mlkit_text_recognition` |
| Image processing | `image` |
| PDF generation | `pdf`, `printing`, `syncfusion_flutter_pdf` |
| State management | `flutter_riverpod` |
| Storage | `path_provider`, `shared_preferences` |
| Sharing | `share_plus` |
