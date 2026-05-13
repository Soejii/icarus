# Finance Feature — Backend Findings & Full Reference

> Written before data layer implementation. Survives context compaction.  
> Source: live API hits against `https://demo.sidigs.com` + Postman collection (SIDIGS API) + sadewa (old Flutter parent app) codebase analysis.  
> Demo student ID: `385` (ZAVIER AKTAM DZAKIAN)  
> Auth: `Authorization: Bearer <token>`

---

## 1. Complete Endpoint Inventory

### 1.1 School Bill Endpoints (prefix: `/api/parent/bill/`)

| # | Method | Path | Body type | Used by screen |
|---|--------|------|-----------|---------------|
| B1 | GET | `/home-bill/:student_id` | — | `FinanceScreen` |
| B2 | GET | `/list-unpaid/:student_id?type=spp\|dpp\|lainnya` | — | `SchoolBillsScreen` |
| B3 | GET | `/list-paid/:student_id?type=spp\|dpp\|lainnya&limit&offset` | — | `SchoolBillsScreen` |
| B4 | GET | `/list-all-bill/:student_id?limit&offset&paginate` | — | `SchoolBillsScreen` |
| B5 | GET | `/get-detail?bill_trx_id=` | — | `DetailTagihanScreen`, `BillPaymentDetailScreen` |
| B6 | GET | `/payment-methods` | — | `SelectPaymentScreen` |
| B7 | GET | `/no-rekening/:student_id` | — | `BankTransferPaymentScreen` |
| B8 | POST | `/create-payment/:slug` | JSON | `VaPaymentScreen`, `PaymentGatewayScreen` |
| B9 | POST | `/submit-transfer` | form-data | `BankTransferPaymentScreen` |
| B10 | POST | `/transfer-confirmation` | form-data (file) | `BankTransferPaymentScreen`, `PendingConfirmationScreen` |
| B11 | POST | `/cancel-transfer` | form-data | `PendingConfirmationScreen` |
| B12 | POST | `/pay-multiple` | JSON | `MultiSelectPaymentScreen` |
| B13 | POST | `/pay-with-emoney` | form-data | `SelectPaymentScreen` |
| B14 | GET | `/download-invoice?bill_trx_id=` | — | `BillPaymentDetailScreen` |

### 1.2 E-money Endpoints (prefix: `/api/parent/bill/`)

| # | Method | Path | Body type | Used by screen |
|---|--------|------|-----------|---------------|
| E1 | GET | `/detail-emoney/:student_id` | — | `EmoneyScreen`, `SelectPaymentScreen` |
| E2 | GET | `/history-emoney/:student_id?limit&offset&paginate` | — | `EmoneyScreen`, `ViewAllHistoryScreen` |
| E3 | GET | `/detail-history-emoney/:id` | — | `DetailPembayaranScreen`, `CanteenPaymentScreen` |
| E4 | POST | `/topup-transfer/:student_id` | form-data | `NominalEntryScreen` |
| E5 | POST | `/emoney-topup-confirmation` | form-data (file) | `EmoneyScreen` |
| E6 | POST | `/emoney-edit-confirmation` | form-data (file) | `EmoneyScreen` |
| E7 | POST | `/emoney-cancel-topup` | form-data | `EmoneyScreen` |

### 1.3 Saving (Pocket Money / Tabungan) Endpoints (prefix: `/api/parent/topup/`)

| # | Method | Path | Body type | Used by screen |
|---|--------|------|-----------|---------------|
| S1 | GET | `/detail-topup-student/:student_id` | — | `SavingsScreen` |
| S2 | GET | `/get-list/:student_id?limit&offset` | — | `SavingsScreen`, `ViewAllHistoryScreen` |
| S3 | GET | `/get-detail-byId?id=` | — | `DetailPembayaranScreen` |

### 1.4 Spending Limit Endpoints (prefix: `/api/parent/transaction/`)

| # | Method | Path | Body type | Used by screen |
|---|--------|------|-----------|---------------|
| L1 | GET | `/get-limit/:student_id` | — | `FinanceScreen` |
| L2 | POST | `/set-limit/:student_id` | JSON | `FinanceScreen` |

**Total: 23 endpoints**

---

## 2. Full Response Shapes (Live API)

### B1 — GET `/api/parent/bill/home-bill/:student_id`

```json
{
  "status": 200,
  "success": true,
  "message": "success",
  "data": {
    "student": {
      "name": "ZAVIER AKTAM DZAKIAN",
      "nis": "23871021",
      "class": "Kelas 1"
    },
    "unpaid_total": 105170208,
    "unpaid_spp": 93286778,
    "unpaid_dpp": 11356430,
    "unpaid_lainnya": 527000,
    "info": "Perhatian!\r\n\r\nHal-hal yang perlu diperhatikan..."
  }
}
```

### B2/B3/B4 — Bill List (list-unpaid / list-paid / list-all-bill)

All three return the same item shape (array):

```json
{
  "id": 2626,
  "bill_id": 505,
  "student_id": 385,
  "registrant_id": null,
  "pay_date": "2025-10-23 18:41:26",
  "status": "installment",
  "last_notified_at": "2025-10-17 08:50:33",
  "evidence_path": "https://nos.wjv-1.neo.id/sidigs-dev/...",
  "pay_amount": 20000,
  "pay_method": "bri",
  "notes": "asdasdasd",
  "action_by": null,
  "payment_id": null,
  "created_at": "2025-10-23 18:37:19",
  "updated_at": "2026-01-15 14:14:53",
  "deleted_at": null,
  "discount": 0,
  "bill": {
    "id": 505,
    "school_id": 44,
    "period_id": null,
    "school_year_id": null,
    "code": "esmartlink1",
    "name": "esmartestwalimuridweb1",
    "amount": 50000,
    "start_date": "2025-10-13",
    "end_date": "2025-10-24",
    "month": "0000-00-00",
    "class": null,
    "school_year": "2",
    "notes": "YAAAAAAAAAAAAAAa",
    "type": "dpp",
    "bill_pos_id": null,
    "is_installment": 1,
    "created_at": "2025-10-23 18:37:19",
    "updated_at": "2025-10-23 18:37:19",
    "deleted_at": null,
    "groups": [],
    "before_discount": 50000
  }
}
```

### B5 — GET `/api/parent/bill/get-detail?bill_trx_id=`

Everything from B4 item plus:

```json
{
  "student": {
    "name": "ZAVIER AKTAM DZAKIAN",
    "nis": "23871021",
    "class_name": "Kelas 1"
  },
  "bill_installment_confirmed": [
    {
      "id": 405,
      "bill_transaction_id": 2626,
      "bill_transfer_id": null,
      "pay_date": "2025-10-23 18:41:26",
      "evidence_path": null,
      "pay_amount": 20000,
      "pay_method": "esmartlink",
      "status": "confirmed",
      "notes": null,
      "action_by": null,
      "payment_id": "f1a2f274-ef75-4ae5-99fe-e9ec560fa523",
      "created_at": "2025-10-23 18:40:58",
      "updated_at": "2025-10-23 18:41:26",
      "deleted_at": null
    }
  ],
  "bill_installment_pending_or_paid": null,
  "latest_transactions": {
    "id": 546,
    "school_id": 44,
    "method_id": null,
    "bill_transaction_id": 2626,
    "emoney_id": null,
    "type": "bill",
    "trx_id": null,
    "external_id": null,
    "partner_service_id": null,
    "redirect_url": null,
    "customer_no": null,
    "virtual_account": null,
    "reference_number": null,
    "billing_type": null,
    "amount": null,
    "notes": null,
    "va_status": null,
    "status": null,
    "datetime_created": null,
    "datetime_payment": null,
    "datetime_expired": null,
    "created_at": "...",
    "updated_at": "...",
    "deleted_at": null
  }
}
```

### B6 — GET `/api/parent/bill/payment-methods`

```json
[
  { "id": 3,  "name": "Emoney",           "slug": "emoney",        "status": true },
  { "id": 12, "name": "VA BSI",           "slug": "bsi",           "status": true },
  { "id": 2,  "name": "Transfer Bank",    "slug": "transfer-bank", "status": true },
  { "id": 5,  "name": "VA BNI",           "slug": "va-bni",        "status": true },
  { "id": 7,  "name": "VA Bank Muamalat", "slug": "bmi",           "status": true },
  { "id": 9,  "name": "VA BRI",           "slug": "bri",           "status": true },
  { "id": 10, "name": "VA BCA",           "slug": "bca",           "status": true },
  { "id": 6,  "name": "Payment Gateway",  "slug": "winpay",        "status": true },
  { "id": 11, "name": "E Smartlink",      "slug": "esmartlink",    "status": true }
]
```

### B7 — GET `/api/parent/bill/no-rekening/:student_id`

```json
{
  "bank_logo": "https://demo.sidigs.com/images/icon-bank-muamalat.png",
  "bank_account": "Bank Muamalat",
  "bank_name": "farhan asrori",
  "bank_number": "0891158222",
  "admin_fee_spp": 0,
  "admin_fee_dpp": 0,
  "admin_fee_lainnya": 0,
  "admin_fee_emoney": 0
}
```

### B8 — POST `/api/parent/bill/create-payment/:slug` (JSON)

Request:
```json
{
  "student_id": 385,
  "bill_trx_id": 2656,
  "payment_type": "bill",
  "amount": 100000,
  "notes": "Testing bayar va bsi"
}
```
`slug` values: `va-bni`, `bri`, `bca`, `bmi`, `bsi`, `esmartlink`, `winpay`  
Response: includes `redirect_url` (winpay/esmartlink), virtual account number (VA methods), `trx_id`, `status`

### B9 — POST `/api/parent/bill/submit-transfer` (form-data)

```
bill_trx_id: 539
amount: 200000
notes: buat spp anak saya
```

### B10 — POST `/api/parent/bill/transfer-confirmation` (form-data)

```
bill_trx_id: 384        (use this, not transfer_id)
evidence: <image file>
```

### B11 — POST `/api/parent/bill/cancel-transfer` (form-data)

```
transfer_id: 11
```

### B12 — POST `/api/parent/bill/pay-multiple` (JSON)

```json
{
  "payment_method": "emoney",
  "student_id": 385,
  "bills": [
    { "bill_trx_id": 2301, "notes": "bayar spp", "amount": 100000 },
    { "bill_trx_id": 2293, "notes": "bayar spp2", "amount": 100000 }
  ]
}
```
`payment_method`: `"emoney"`, `"winpay"`, `"transfer-bank"`

### B13 — POST `/api/parent/bill/pay-with-emoney` (form-data)

```
student_id: 385
bill_trx_id: 508
amount: 10000
notes: buat spp anak saya
```

### E1 — GET `/api/parent/bill/detail-emoney/:student_id`

```json
{
  "name": "ZAVIER AKTAM DZAKIAN",
  "school_name": "Sekolah Alam",
  "card_id": "123456",
  "saldo_emoney": "Rp.91.352.023",
  "total_topup": "Rp.113.545.687",
  "total_payment": "Rp.20.136.020",
  "total_cashout": "Rp.1.385.821",
  "total_transaction": 326
}
```

### E2 — GET `/api/parent/bill/history-emoney/:student_id`

```json
{
  "student": {
    "name": "ZAVIER AKTAM DZAKIAN",
    "class": "Kelas 1",
    "saldo_emoney": "Rp.91.352.023"
  },
  "emoney": [
    {
      "id": 769,
      "student_id": 385,
      "teacher_id": null,
      "amount": "-500.000",
      "notes": "Pembayaran Tagihan Tagihan DPP Puasa",
      "confirmation_photo": null,
      "type": "transfer",
      "transaction": "bill_pay",
      "merchant_name": null,
      "list_item": null,
      "status": "success",
      "received_by": null,
      "given_by": null,
      "date": "2026-03-05 16:18:41",
      "action_by": null,
      "payment_id": null,
      "created_at": "5 Maret 2026, 16:18 WIB",
      "updated_at": "2026-03-05 16:18:41",
      "deleted_at": null,
      "payment_transaction": null
    }
  ]
}
```

### E3 — GET `/api/parent/bill/detail-history-emoney/:id`

```json
{
  "id": 15,
  "student_id": 385,
  "teacher_id": null,
  "amount": "Rp.100.001",
  "notes": "adada adada adadad",
  "confirmation_photo": null,
  "type": "transfer",
  "transaction": "topup",
  "merchant_name": null,
  "list_item": null,
  "status": "failed",
  "received_by": null,
  "given_by": null,
  "date": "2022-01-25 00:51:16",
  "action_by": null,
  "payment_id": null,
  "created_at": "2022-01-25 07:51:16",
  "updated_at": "2022-03-11 15:06:02",
  "deleted_at": null,
  "student": {
    "name": "ZAVIER AKTAM DZAKIAN",
    "nis": "23871021"
  },
  "transaction_name": "Pembelian di ",
  "payment_transaction": null
}
```

**Canteen note:** When `transaction == "canteen"`, `list_item` contains a formatted string:
```
"- Nasi Goreng (1) Rp. 15000\n- Es Teh (2) Rp. 5000\n"
```
Parse: split `\n` → each line: skip `"- "`, extract name (before `(`), qty (inside `()`), price (after `Rp. `).

### E4 — POST `/api/parent/bill/topup-transfer/:student_id` (form-data)

Request:
```
amount: 100000
notes: Buat jajan
```
Response `data` (`TopUpModel`): transaction record + bank details:
```json
{
  "bank_logo": "...",
  "bank_account": "Bank Muamalat",
  "bank_name": "farhan asrori",
  "bank_number": "0891158222",
  "admin_fee_emoney": 0
}
```
Flow: → E5 (upload proof) → confirmed. Cancel with E7 if needed. Re-upload with E6.

### E5 — POST `/api/parent/bill/emoney-topup-confirmation` (form-data)

```
emoney_id: 1
evidence: <image file>
```

### E6 — POST `/api/parent/bill/emoney-edit-confirmation` (form-data)

```
emoney_id: 1
evidence: <image file>   (replacement proof)
```

### E7 — POST `/api/parent/bill/emoney-cancel-topup` (form-data)

```
emoney_id: 13
```

### S1 — GET `/api/parent/topup/detail-topup-student/:student_id`

```json
{
  "name": "ZAVIER AKTAM DZAKIAN",
  "school_name": "Sekolah Alam",
  "card_id": "123456",
  "saldo_topup": "Rp.640.000",
  "total_topup": "Rp.750.000",
  "total_cashout": "Rp.110.000",
  "total_transaction": 8
}
```

### S2 — GET `/api/parent/topup/get-list/:student_id`

```json
{
  "student": { "name": "ZAVIER AKTAM DZAKIAN", "saldo": "Rp.640.000" },
  "topup": [
    {
      "id": 97,
      "student_id": 385,
      "amount": 100000,
      "notes": "asd",
      "confirmation_photo": null,
      "type": "cash",
      "confirmed": 1,
      "received_by": "321",
      "given_by": "123",
      "date": "2025-07-16 12:32:00",
      "created_at": "2025-07-16 19:32:24",
      "updated_at": "2025-07-16 19:32:24",
      "deleted_at": null,
      "transaction": "cashout"
    }
  ]
}
```

### S3 — GET `/api/parent/topup/get-detail-byId?id=`

Single topup transaction + full nested student record (60+ fields).  
Returns 401 if transaction doesn't belong to the authenticated parent's student.

### L1 — GET `/api/parent/transaction/get-limit/:student_id`

```json
{
  "type": "Harian",
  "amount": 50000
}
```
`type` values: `"Tidak Dibatasi"`, `"Harian"`, `"Mingguan"`, `"Bulanan"`, `"Tahunan"`

### L2 — POST `/api/parent/transaction/set-limit/:student_id` (JSON)

```json
{
  "type": "Harian",
  "amount": 50000
}
```

---

## 3. Type Mappings

### BillStatusType ← `status`
| API | Enum | Display |
|-----|------|---------|
| `unpaid` | `BillStatusType.unpaid` | Belum Bayar |
| `paid` | `BillStatusType.paid` | Lunas |
| `pending` | `BillStatusType.pending` | Menunggu Konfirmasi |
| `installment` | `BillStatusType.installment` | Cicilan |
| `confirmed` | `BillStatusType.confirmed` | Dikonfirmasi |

### BillCategoryType ← `bill.type`
| API | Enum |
|-----|------|
| `spp` | `BillCategoryType.spp` |
| `dpp` | `BillCategoryType.dpp` |
| `lainnya` | `BillCategoryType.lainnya` |

### TransactionType ← `topup[].transaction`
| API | Enum |
|-----|------|
| `topup` | `TransactionType.kredit` |
| `cashout` | `TransactionType.debit` |

### E-money transaction types (`transaction` field in E2/E3)
`topup`, `cashout`, `bill_pay`, `canteen` — no enum defined yet

---

## 4. Inconsistencies & Quirks Found

### 4.1 Balance format inconsistency across endpoints
- `S1` saving summary: `saldo_topup` = `"Rp.640.000"` (formatted string)
- `S2` saving history: `topup[].amount` = `100000` (raw integer)
- `E1` emoney summary: `saldo_emoney` = `"Rp.91.352.023"` (formatted string)
- `E2` emoney history: `amount` = `"-500.000"` (formatted string with sign, no "Rp.")
- `E3` emoney detail: `amount` = `"Rp.100.001"` (formatted string with "Rp.")
- `B7` no-rekening: `admin_fee_*` = `0` (raw integer)

Three different number formats across the same feature. No consistent raw integer field for calculations.

### 4.2 `created_at` is human-readable in E2 but ISO in everything else
- `E2` emoney history: `created_at` = `"5 Maret 2026, 16:18 WIB"` (Indonesian, not parseable)
- All other endpoints: `created_at` = `"2025-10-23 18:37:19"` (MySQL datetime)
- `date` field is always the reliable datetime in emoney history.

### 4.3 `student` object shape varies by endpoint
- `B5` get-detail: `{ name, nis, class_name }`
- `E3` detail-history-emoney: `{ name, nis }` (no class)
- `B1` home-bill: `{ name, nis, class }` (key is `class` not `class_name`)
- `S3` topup detail: full student record, 60+ fields (overkill)

### 4.4 Three separate bill list endpoints doing overlapping work
`list-all-bill`, `list-unpaid`, `list-paid` all return the same item shape. The only difference is the filter. Could be one endpoint with a `status` query param.

### 4.5 `latest_transactions` in B5 is mostly null
In the live response, `latest_transactions` has 20+ fields, almost all `null`. Only populated after certain payment flows (VA, winpay).

### 4.6 `deleted_at` exposed on every model
Every response includes `deleted_at: null`. This is a backend implementation detail (soft delete) that has no use on the client side.

### 4.7 `bill` object in list responses includes internal fields
`school_id`, `period_id`, `school_year_id`, `bill_pos_id` are all internal FK fields the client never needs.

### 4.8 `student_id` redundancy in list responses
Every bill payment record includes `student_id: 385` — redundant since the endpoint is already scoped to `/list-all-bill/385`.

### 4.9 `topup-transfer` vs `emoney` naming collision
The saving feature uses `/api/parent/topup/` prefix.  
The e-money topup uses `/api/parent/bill/topup-transfer/`.  
Both involve "topup" but are completely separate wallets. Easy to confuse.

### 4.10 `registrant_id` always null
In every bill list response observed, `registrant_id` is always `null`. Unknown if ever populated.

### 4.11 `pay_multiple` endpoint for B13 accepts inconsistent body
`pay-with-emoney` uses form-data but `pay-multiple` (which also supports emoney as a method) uses JSON. Same operation, different content types.

### 4.12 `B13 pay-with-emoney` is redundant with `B12 pay-multiple`
`pay-with-emoney` pays a single bill with emoney. `pay-multiple` with `payment_method: "emoney"` and a single item in `bills[]` does the same thing. Two endpoints for one operation.

### 4.13 `transfer-confirmation` has a disabled `transfer_id` field
In Postman, `transfer_id` is marked disabled with the note "use bill_trx_id instead of this". The field exists but shouldn't be used.

### 4.14 `topup/get-detail-byId` returns 60+ student fields
The saving transaction detail returns the full student DB row nested inside. The client only needs `name`, `nis`, and maybe `card_id`. Everything else (`address`, `religion`, `birthplace`, `skhun`, `no_kps`, `lintang`, `bujur`, etc.) is irrelevant noise.

### 4.15 `month` field in bill is always `"0000-00-00"` for non-SPP bills
For DPP and lainnya bills, `month` is always `"0000-00-00"`. Only meaningful for SPP (monthly billing). Should be nullable.

### 4.16 `action_by` is always null in parent-facing responses
Appears in both bill and emoney responses. Likely set only by admin/teacher actions. Client never needs it.

---

## 5. Screen → API Map (complete)

| Screen | File | API calls |
|--------|------|-----------|
| `FinanceScreen` | `finance_screen.dart` | B1, L1 |
| `SchoolBillsScreen` | `school_bills_screen.dart` | B2, B3, B4 |
| `DetailTagihanScreen` | `detail_tagihan_screen.dart` | B5 |
| `BillPaymentDetailScreen` | `bill_payment_detail_screen.dart` | B5, B14 |
| `SelectPaymentScreen` / `PilihMetodeKeuanganScreen` | both screens | B6, E1, B13 |
| `BankTransferPaymentScreen` | `bank_transfer_payment_screen.dart` | B7, B9, B10 |
| `VaPaymentScreen` | `va_payment_screen.dart` | B8 |
| `PaymentGatewayScreen` | `payment_gateway_screen.dart` | B8 |
| `PendingConfirmationScreen` | `pending_confirmation_screen.dart` | B10, B11 |
| `MultiSelectPaymentScreen` | `multi_select_payment_screen.dart` | B12 |
| `EmoneyScreen` | `emoney_screen.dart` | E1, E2, E4, E5, E6, E7 |
| `NominalEntryScreen` | `nominal_entry_screen.dart` | E4 |
| `CanteenPaymentScreen` | `canteen_payment_screen.dart` | E3 (parses `list_item`) |
| `DetailPembayaranScreen` | `detail_pembayaran_screen.dart` | E3, S3 |
| `ViewAllHistoryScreen` | `view_all_history_screen.dart` | E2, S2 |
| `SavingsScreen` | `savings_screen.dart` | S1, S2 |
| `TransactionSuccessScreen` | `transaction_success_screen.dart` | none (display only) |

---

## 6. Payment Flow Summary

```
Bill list (B2/B3/B4)
  → Bill detail (B5)
    → Select payment method (B6 + E1 for balance)
      → Emoney: B13 → done
      → Winpay/esmartlink: B8 → redirect_url → WebView → callback
      → VA (BNI/BRI/BCA/BSI/BMI): B8 → VA number shown → user transfers → B10 (upload proof)
      → Manual bank transfer: B7 (get bank details) → B9 (submit) → B10 (upload proof)
      → Cancel pending: B11

E-money topup flow:
  NominalEntryScreen → E4 (create pending topup + get bank details)
    → User transfers to school bank
    → E5 (upload proof) → confirmed
    → E6 (re-upload if needed)
    → E7 (cancel if abandoned)

Multiple bills:
  MultiSelectPaymentScreen → B12 (emoney/winpay/transfer-bank)
```

---

## 7. Architecture Notes for Data Layer

- No data layer exists yet in `lib/features/finance/`. Only screens, widgets, and domain types.
- Follow existing patterns from `lib/features/announcement/` and `lib/features/chat/`.
- 3 datasources needed: `BillRemoteDataSource`, `EmoneyRemoteDataSource`, `SavingRemoteDataSource`
- Form-data endpoints need `FormData` / `MultipartFile` from Dio — not plain JSON.
- Signed S3 URLs in `evidence_path` (paid bills) expire after 24h — do not cache.
- `student_id = 385` hardcoded for demo. In prod, source from parent profile provider.
- `created_at` in E2 (emoney history) is an Indonesian string — always use `date` field for datetime logic.
- Canteen items are parsed from a formatted string in `list_item`, not a structured array.
