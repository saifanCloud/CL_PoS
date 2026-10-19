# Point of Sale (POS) Architecture

## Overview
This Point of Sale (POS) application is built using a **Monorepo** architecture to streamline development between the cashier frontend application (Flutter) and the backend API (Node.js).

## Architecture Diagram

```mermaid
graph TD
    subgraph Client Applications
        A[Flutter POS App - Android/iOS/Desktop/Web]
    end

    subgraph Backend Services
        B[Node.js / Express API Server]
        C[PostgreSQL Database]
        D[Redis Cache / Session]
    end

    subgraph Shared Contracts
        E[@pos/shared Types & DTOs]
    end

    A -->|REST API / HTTP| B
    B -->|Query / ORM| C
    B -->|Cache| D
    A -.->|Shared Schema & Models| E
    B -.->|Shared Schema & Models| E
```

## Folder Structure

```
CL_PoS/
├── apps/
│   ├── pos_app/               # Flutter cross-platform POS application
│   │   ├── android/
│   │   ├── ios/
│   │   ├── windows/
│   │   ├── web/
│   │   ├── lib/
│   │   │   ├── core/          # App constants, network client, theme
│   │   │   ├── features/      # Feature-driven modules (catalog, cart, orders, auth)
│   │   │   └── shared/        # Reusable UI widgets
│   │   └── pubspec.yaml
│   └── api/                   # Node.js + TypeScript backend API
│       ├── src/
│       │   ├── config/        # Environment and DB config
│       │   ├── controllers/   # Request handlers (Products, Orders, Health)
│       │   ├── middlewares/   # Error handling, auth, validation
│       │   ├── routes/        # Express route definitions
│       │   ├── services/      # Business logic
│       │   ├── app.ts         # Express app configuration
│       │   └── server.ts      # Server listener
│       ├── package.json
│       └── tsconfig.json
├── packages/
│   └── shared/                # Shared TypeScript types, interfaces, DTOs
│       ├── src/
│       │   ├── types/         # Product, Order, User, Payment models
│       │   └── index.ts
│       ├── package.json
│       └── tsconfig.json
├── docs/                      # Project documentation and specifications
│   └── architecture.md
├── docker-compose.yml         # Local PostgreSQL & Redis environment
├── package.json               # Root monorepo workspace configuration
└── README.md                  # Quickstart guide
```

## Key POS Modules
1. **Catalog & Inventory**: Product management, categories, SKU, barcode, and item stock.
2. **Point of Sale (Cashier)**: Quick product grid, shopping cart, tax/discount calculation, and checkout.
3. **Payment Methods**: Cash, QRIS, Debit/Credit Card, and Bank Transfer.
4. **History & Reports**: Transaction list, digital receipts, thermal printer integration, and daily sales summary.
