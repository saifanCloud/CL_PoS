# CL Point of Sale (POS) - Monorepo

Monorepo untuk sistem aplikasi Point of Sale (POS) menggunakan **Flutter** (Frontend Kasir / Mobile / Desktop / Web) dan **Node.js + TypeScript** (Backend REST API).

---

## 📁 Struktur Monorepo

```text
CL_PoS/
├── apps/
│   ├── pos_app/               # Flutter App (Kasir / POS)
│   │   ├── lib/
│   │   │   ├── core/          # Konfigurasi, constants, network & theme
│   │   │   ├── features/      # Modul fitur (katalog, keranjang, transaksi, kasir)
│   │   │   └── shared/        # Komponen UI bersama
│   │   └── pubspec.yaml
│   │
│   └── api/                   # Node.js + TypeScript REST API (Express)
│       ├── src/
│       │   ├── config/        # Konfigurasi database & environment
│       │   ├── controllers/   # Controller endpoint API (Produk, Order, dll.)
│       │   ├── middlewares/   # Middleware error handling, auth, logger
│       │   ├── routes/        # Rute API RESTful (/api/products, /api/orders)
│       │   └── server.ts      # Server entry point
│       └── package.json
│
├── packages/
│   └── shared/                # Shared package berisi tipe data dan interface POS
│       ├── src/types/         # Product, Order, User, PaymentMethod
│       └── package.json
│
├── docs/                      # Dokumentasi & diagram arsitektur
├── docker-compose.yml         # Container lokal untuk PostgreSQL & Redis
└── package.json               # Konfigurasi Root Workspace NPM
```

---

## 🚀 Panduan Menjalankan Project

### 1. Menjalankan Backend (Node.js API)
Jalankan perintah ini di root folder:
```bash
npm run dev:api
```
Server akan berjalan di:
- **Base URL**: `http://localhost:4000`
- **Health Check**: `http://localhost:4000/api/health`
- **Produk API**: `http://localhost:4000/api/products`
- **Order / Transaksi**: `http://localhost:4000/api/orders`

### 2. Menjalankan Aplikasi Flutter (POS)
Pindah ke direktori aplikasi Flutter atau jalankan langsung:
```bash
cd apps/pos_app
flutter run
```
*Dapat dijalankan di Windows Desktop, Android Emulator/Device, Web Browser, macOS, atau iOS.*

### 3. Menjalankan Database Lokal (Opsional dengan Docker)
Jika ingin menggunakan PostgreSQL & Redis lokal:
```bash
docker-compose up -d
```

---

## 🛠️ Fitur Awal yang Sudah Disediakan
- ✅ **Struktur Monorepo Modern** berbasis NPM Workspaces.
- ✅ **Aplikasi Flutter Kasir**: Grid produk interaktif, keranjang belanja (cart), hitung total harga, dan dialog checkout pembayaran.
- ✅ **Node.js REST API**: Middleware CORS, Helmet (keamanan), Morgan (logging), error handler terpusat, serta endpoint produk dan order POS.
- ✅ **Shared Models & DTO**: Tipe data model bersama (`User`, `Product`, `Order`, `PaymentMethod`, `OrderStatus`).

