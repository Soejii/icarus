# Finance Feature — API Map

> Base URL: `https://demo.sidigs.com`  
> Auth: `Authorization: Bearer <token>` on all endpoints  
> All responses wrap data in `{ status, success, message, data, exceptions }`  
> Demo student ID: `385`

---

## Endpoint Index

| # | Method | Path | Purpose | Screen(s) |
|---|--------|------|---------|-----------|
| 1 | GET | `/api/parent/bill/home-bill/:student_id` | Unpaid summary totals + info text | `FinanceScreen` |
| 2 | GET | `/api/parent/bill/list-unpaid/:student_id` | Unpaid bills by category | `SchoolBillsScreen` |
| 3 | GET | `/api/parent/bill/list-paid/:student_id` | Paid bills by category | `SchoolBillsScreen` |
| 4 | GET | `/api/parent/bill/list-all-bill/:student_id` | All bills (any status) | `SchoolBillsScreen` |
| 5 | GET | `/api/parent/bill/get-detail` | Single bill transaction detail | `DetailTagihanScreen`, `BillPaymentDetailScreen` |
| 6 | GET | `/api/parent/bill/payment-methods` | Available payment methods | `SelectPaymentScreen` |
| 7 | GET | `/api/parent/bill/no-rekening/:student_id` | Bank account info + admin fees | `BankTransferPaymentScreen` |
| 8 | POST | `/api/parent/bill/create-payment/:slug` | Initiate payment (VA, gateway, etc.) | `PaymentGatewayScreen`, `VaPaymentScreen` |
| 9 | POST | `/api/parent/bill/submit-transfer` | Submit bank transfer proof | `BankTransferPaymentScreen` |
| 10 | POST | `/api/parent/bill/cancel-transfer` | Cancel pending bank transfer | `PendingConfirmationScreen` |
| 11 | POST | `/api/parent/bill/pay-multiple` | Pay multiple bills at once | `MultiSelectPaymentScreen` |
| 12 | GET | `/api/parent/bill/download-invoice` | Download payment invoice | `BillPaymentDetailScreen` |
| 13 | GET | `/api/parent/bill/detail-emoney/:student_id` | E-money balance summary | `EmoneyScreen` |
| 14 | GET | `/api/parent/bill/history-emoney/:student_id` | E-money transaction history | `EmoneyScreen`, `ViewAllHistoryScreen` |
| 15 | GET | `/api/parent/bill/detail-history-emoney/:id` | Single e-money transaction detail | `DetailPembayaranScreen` |
| 16 | POST | `/api/parent/bill/pay-with-emoney` | Pay bill using e-money balance | `SelectPaymentScreen` |
| 17 | POST | `/api/parent/bill/emoney-topup-confirmation` | Confirm e-money top-up | `EmoneyScreen` |
| 18 | POST | `/api/parent/bill/emoney-cancel-topup` | Cancel pending e-money top-up | `EmoneyScreen` |
| 19 | GET | `/api/parent/topup/detail-topup-student/:student_id` | Saving (pocket money) balance summary | `SavingsScreen` |
| 20 | GET | `/api/parent/topup/get-list/:student_id` | Saving transaction history | `SavingsScreen`, `ViewAllHistoryScreen` |
| 21 | GET | `/api/parent/topup/get-detail-byId` | Single saving transaction detail | `DetailPembayaranScreen` |

---

## School Bill Endpoints

### 1. GET `/api/parent/bill/home-bill/:student_id`

Home screen summary — unpaid totals broken down by category, plus a school info/announcement text.

**Response `data`:**
```json
{
  "student": {
    "name": "ZAVIER AKTAM DZAKIAN",
    "nis": "23871021",
    "class": "Kelas 1"
  },
  "unpaid_total": 105170208,
  "unpaid_spp": 93286778,
  "unpaid_dpp": 11356430,
  "unpaid_lainnya": 527000,
  "info": "Perhatian! ..."
}
```

| Field | Type | Notes |
|-------|------|-------|
| `unpaid_total` | int | Total unpaid across all categories (raw Rupiah) |
| `unpaid_spp` | int | Unpaid SPP total |
| `unpaid_dpp` | int | Unpaid DPP total |
| `unpaid_lainnya` | int | Unpaid "Lainnya" total |
| `info` | string | School payment announcement/info text |

**Used by:** `FinanceScreen` — `FinanceUnpaidSummaryWidget`, `FinanceBalanceRowWidget`

---

### 2. GET `/api/parent/bill/list-unpaid/:student_id`

List of unpaid/installment bills for a student, filtered by category.

**Query params:** `type` (`spp` | `dpp` | `lainnya`), `status` (`unpaid`), `limit`, `offset`

**Response `data`** (array of payment records — same shape as `list-all-bill`, see #4 below)

**Used by:** `SchoolBillsScreen` — unpaid tab per category

---

### 3. GET `/api/parent/bill/list-paid/:student_id`

List of confirmed/paid bills, filtered by category.

**Query params:** `type` (`spp` | `dpp` | `lainnya`), `limit`, `offset`

**Response `data`** (array — same shape as `list-all-bill`. `evidence_path` is a signed S3 URL when present.)

**Used by:** `SchoolBillsScreen` — paid history tab

---

### 4. GET `/api/parent/bill/list-all-bill/:student_id`

All bill payment records regardless of status. Each item is a **payment record** carrying both the bill definition and the payment state.

**Query params:** `limit`, `offset`, `paginate` (all optional)

**Response `data`** (array):
```json
{
  "id": 2626,
  "bill_id": 505,
  "student_id": 385,
  "pay_date": "2025-10-23 18:41:26",
  "status": "installment",
  "pay_amount": 20000,
  "pay_method": "bri",
  "evidence_path": null,
  "discount": 0,
  "notes": "asdasdasd",
  "bill": {
    "id": 505,
    "name": "esmartestwalimuridweb1",
    "code": "esmartlink1",
    "amount": 50000,
    "before_discount": 50000,
    "type": "dpp",
    "start_date": "2025-10-13",
    "end_date": "2025-10-24",
    "month": "0000-00-00",
    "is_installment": 1,
    "notes": "...",
    "school_year": null,
    "class": null,
    "groups": []
  }
}
```

**Payment record fields:**

| Field | Type | Notes |
|-------|------|-------|
| `id` | int | Payment record ID (use as `bill_trx_id` for detail/invoice) |
| `status` | string | → `BillStatusType` (`unpaid`, `paid`, `pending`, `installment`, `confirmed`) |
| `pay_amount` | int | Amount paid so far |
| `pay_method` | string? | `bri`, `bca`, `emoney`, `transfer`, `winpay`, etc. |
| `evidence_path` | string? | Signed S3 URL to payment proof image |
| `discount` | int | Discount applied (0 if none) |
| `pay_date` | string? | Date of last payment |

**Nested `bill` fields:**

| Field | Type | Notes |
|-------|------|-------|
| `bill.name` | string | Display name |
| `bill.amount` | int | Total bill amount |
| `bill.before_discount` | int | Original amount pre-discount |
| `bill.type` | string | → `BillCategoryType` (`spp`, `dpp`, `lainnya`) |
| `bill.is_installment` | int | `1` = supports installments |
| `bill.start_date` / `end_date` | string | Bill period (`yyyy-MM-dd`) |
| `bill.month` | string? | SPP month reference |

**Used by:** `SchoolBillsScreen` (all bills tab), `FinanceScreen` (summary count)

---

### 5. GET `/api/parent/bill/get-detail?bill_trx_id=`

Full detail of a single bill transaction. Includes installment history and latest payment transaction.

**Query params:** `bill_trx_id` (int)

**Response `data`:**
```json
{
  "id": 2626,
  "bill_id": 505,
  "student_id": 385,
  "status": "installment",
  "pay_amount": 20000,
  "pay_method": "bri",
  "evidence_path": null,
  "discount": 0,
  "student": {
    "name": "ZAVIER AKTAM DZAKIAN",
    "nis": "23871021",
    "class_name": "Kelas 1"
  },
  "bill_installment_confirmed": [
    {
      "id": 405,
      "bill_transaction_id": 2626,
      "pay_date": "2025-10-23 18:41:26",
      "pay_amount": 20000,
      "pay_method": "esmartlink",
      "status": "confirmed",
      "payment_id": "f1a2f274-ef75-4ae5-99fe-e9ec560fa523"
    }
  ],
  "bill_installment_pending_or_paid": null,
  "latest_transactions": { ... }
}
```

| Field | Type | Notes |
|-------|------|-------|
| `bill_installment_confirmed` | array? | Confirmed installment payment history |
| `bill_installment_pending_or_paid` | object? | Most recent pending/paid installment |
| `latest_transactions` | object? | Latest payment gateway transaction record |
| `student.class_name` | string | Class display name |

**Used by:** `DetailTagihanScreen`, `BillPaymentDetailScreen`

---

### 6. GET `/api/parent/bill/payment-methods`

Returns all active payment methods for this school.

**Response `data`** (array):
```json
[
  { "id": 3,  "name": "Emoney",           "slug": "emoney",        "status": true },
  { "id": 2,  "name": "Transfer Bank",    "slug": "transfer-bank", "status": true },
  { "id": 5,  "name": "VA BNI",           "slug": "va-bni",        "status": true },
  { "id": 9,  "name": "VA BRI",           "slug": "bri",           "status": true },
  { "id": 10, "name": "VA BCA",           "slug": "bca",           "status": true },
  { "id": 12, "name": "VA BSI",           "slug": "bsi",           "status": true },
  { "id": 7,  "name": "VA Bank Muamalat", "slug": "bmi",           "status": true },
  { "id": 6,  "name": "Payment Gateway",  "slug": "winpay",        "status": true },
  { "id": 11, "name": "E Smartlink",      "slug": "esmartlink",    "status": true }
]
```

The `slug` is what gets passed to `create-payment/:slug`.

**Used by:** `SelectPaymentScreen` — `PaymentMethodRadioCard`

---

### 7. GET `/api/parent/bill/no-rekening/:student_id`

School bank account info for manual transfer, plus admin fees per category.

**Response `data`:**
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

**Used by:** `BankTransferPaymentScreen` — `BankInfoWidget`

---

### 8. POST `/api/parent/bill/create-payment/:slug`

Initiates a payment for a bill. Response varies by method (VA number, redirect URL, etc.).

**Path params:** `slug` — from `payment-methods` (`va-bni`, `bri`, `bca`, `bmi`, `bsi`, `esmartlink`, `winpay`)

**Request body (JSON):**
```json
{
  "student_id": 385,
  "bill_trx_id": 2656,
  "payment_type": "bill",
  "amount": 100000,
  "notes": "Testing bayar va bsi"
}
```

| Field | Type | Notes |
|-------|------|-------|
| `student_id` | int | Student ID |
| `bill_trx_id` | int | Payment record ID from bill list |
| `payment_type` | string | `"bill"` or `"topup-emoney"` |
| `amount` | int | Amount to pay |
| `notes` | string? | Optional notes |

**Used by:** `VaPaymentScreen`, `PaymentGatewayScreen`

---

### 9. POST `/api/parent/bill/submit-transfer`

Submits a bank transfer declaration (no photo proof — just amount + notes).

**Request body (form-data):**
| Field | Type | Notes |
|-------|------|-------|
| `bill_trx_id` | text | Payment record ID |
| `amount` | text | Transfer amount |
| `notes` | text | Transfer notes |

**Used by:** `BankTransferPaymentScreen`

---

### 9b. POST `/api/parent/bill/transfer-confirmation`

Uploads photo proof for an existing bank transfer.

**Request body (form-data):**
| Field | Type | Notes |
|-------|------|-------|
| `bill_trx_id` | text | Payment record ID |
| `evidence` | file | Photo proof (image file) |

**Used by:** `BankTransferPaymentScreen`, `PendingConfirmationScreen`

---

### 10. POST `/api/parent/bill/cancel-transfer`

Cancels a pending bank transfer.

**Request body (form-data):**
| Field | Type | Notes |
|-------|------|-------|
| `transfer_id` | text | Transfer record ID |

**Used by:** `PendingConfirmationScreen`

---

### 11. POST `/api/parent/bill/pay-multiple`

Pays multiple bills in a single request.

**Request body (JSON):**
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

| Field | Type | Notes |
|-------|------|-------|
| `payment_method` | string | `"emoney"`, `"winpay"`, `"transfer-bank"` |
| `student_id` | int | Student ID |
| `bills` | array | Each item: `bill_trx_id`, `notes`, `amount` |

**Used by:** `MultiSelectPaymentScreen`

---

### 12. GET `/api/parent/bill/download-invoice?bill_trx_id=`

Returns/redirects to an invoice PDF for the given bill transaction.

**Query params:** `bill_trx_id` (int)

**Used by:** `BillPaymentDetailScreen` — `DownloadReceiptButton`

---

## E-money Endpoints

### 13. GET `/api/parent/bill/detail-emoney/:student_id`

E-money wallet summary.

**Response `data`:**
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

**Note:** Balances are pre-formatted Rupiah strings.

**Used by:** `EmoneyScreen` — `EmoneyBalanceHeaderWidget`

---

### 14. GET `/api/parent/bill/history-emoney/:student_id`

Paginated e-money transaction history.

**Query params:** `limit`, `offset`, `paginate`

**Response `data`:**
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
      "amount": "-500.000",
      "notes": "Pembayaran Tagihan Tagihan DPP Puasa",
      "type": "transfer",
      "transaction": "bill_pay",
      "status": "success",
      "date": "2026-03-05 16:18:41",
      "created_at": "5 Maret 2026, 16:18 WIB",
      "merchant_name": null,
      "list_item": null,
      "confirmation_photo": null,
      "received_by": null,
      "given_by": null,
      "payment_transaction": null
    }
  ]
}
```

| Field | Type | Notes |
|-------|------|-------|
| `amount` | string | Pre-formatted with sign: `"+100.000"` or `"-500.000"` |
| `transaction` | string | `topup`, `cashout`, `bill_pay`, `canteen`, etc. |
| `type` | string | `cash`, `transfer`, etc. |
| `status` | string | `success`, `failed`, `pending` |
| `created_at` | string | Human-readable Indonesian format: `"5 Maret 2026, 16:18 WIB"` |

**Used by:** `EmoneyScreen`, `ViewAllHistoryScreen`

---

### 15. GET `/api/parent/bill/detail-history-emoney/:id`

Single e-money transaction detail.

**Response `data`:** Same fields as a single `emoney[]` item above, plus:
```json
{
  "student": { "name": "ZAVIER AKTAM DZAKIAN", "nis": "23871021" },
  "transaction_name": "Pembelian di ",
  "payment_transaction": null
}
```

**Used by:** `DetailPembayaranScreen`

---

### 16. POST `/api/parent/bill/pay-with-emoney`

Pay a bill using e-money balance.

**Request body (form-data):**
| Field | Type | Notes |
|-------|------|-------|
| `student_id` | text | Student ID |
| `bill_trx_id` | text | Payment record ID |
| `amount` | text | Amount to pay |
| `notes` | text | Optional notes |

**Used by:** `SelectPaymentScreen`

---

### 17. POST `/api/parent/bill/emoney-topup-confirmation`

Upload proof photo for a pending e-money top-up.

**Request body (form-data):**
| Field | Type | Notes |
|-------|------|-------|
| `emoney_id` | text | E-money transaction ID |
| `evidence` | file | Photo proof (image file) |

**Used by:** `EmoneyScreen`

---

### 17b. POST `/api/parent/bill/emoney-edit-confirmation`

Replace the proof photo on an existing e-money top-up confirmation.

**Request body (form-data):** Same as `emoney-topup-confirmation` (`emoney_id` + `evidence` file)

**Used by:** `EmoneyScreen`

---

### 18. POST `/api/parent/bill/emoney-cancel-topup`

Cancel a pending e-money top-up.

**Request body (form-data):**
| Field | Type | Notes |
|-------|------|-------|
| `emoney_id` | text | E-money transaction ID |

**Used by:** `EmoneyScreen`

---

### 18b. POST `/api/parent/bill/topup-transfer/:student_id`

Initiate an e-money top-up via bank transfer. Creates a pending topup transaction the parent then confirms with a photo.

**Path params:** `student_id`

**Request body (form-data):**
| Field | Type | Notes |
|-------|------|-------|
| `amount` | text | Top-up amount (integer) |
| `notes` | text | Optional notes |

**Response `data`:** `TopUpModel` — includes transaction record + bank details (`bank_logo`, `bank_account`, `bank_name`, `bank_number`, `admin_fee_emoney`)

**Flow:** topup-transfer → emoney-topup-confirmation (upload proof) → confirmed. Can cancel with emoney-cancel-topup.

**Used by:** `NominalEntryScreen`

---

## Spending Limit Endpoints

### L1. GET `/api/parent/transaction/get-limit/:student_id`

Returns the current spending limit set for the student's e-money.

**Response `data`:**
```json
{
  "type": "Harian",
  "amount": 50000
}
```

| Field | Type | Notes |
|-------|------|-------|
| `type` | string | `"Tidak Dibatasi"`, `"Harian"`, `"Mingguan"`, `"Bulanan"`, `"Tahunan"` |
| `amount` | int? | Limit amount, null if `"Tidak Dibatasi"` |

**Used by:** `FinanceScreen` — `FinancePocketLimitWidget`

---

### L2. POST `/api/parent/transaction/set-limit/:student_id`

Set or update the spending limit for a student.

**Request body (JSON):**
```json
{
  "type": "Harian",
  "amount": 50000
}
```

**Used by:** `FinanceScreen` — `FinancePocketLimitWidget`

---

## Saving (Pocket Money) Endpoints

### 19. GET `/api/parent/topup/detail-topup-student/:student_id`

Saving wallet balance summary.

**Response `data`:**
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

**Note:** Balances are pre-formatted Rupiah strings (different key names from e-money: `saldo_topup` vs `saldo_emoney`).

**Used by:** `SavingsScreen` — `SavingsBalanceHeaderWidget`

---

### 20. GET `/api/parent/topup/get-list/:student_id`

Paginated saving transaction history.

**Query params:** `limit`, `offset`

**Response `data`:**
```json
{
  "student": { "name": "ZAVIER AKTAM DZAKIAN", "saldo": "Rp.640.000" },
  "topup": [
    {
      "id": 97,
      "student_id": 385,
      "amount": 100000,
      "notes": "asd",
      "type": "cash",
      "confirmed": 1,
      "transaction": "cashout",
      "date": "2025-07-16 12:32:00",
      "created_at": "2025-07-16 19:32:24",
      "confirmation_photo": null,
      "received_by": "321",
      "given_by": "123"
    }
  ]
}
```

| Field | Type | Notes |
|-------|------|-------|
| `amount` | int | Raw Rupiah integer (unlike e-money which uses formatted strings) |
| `transaction` | string | `topup` or `cashout` → `TransactionType.kredit/debit` |
| `confirmed` | int | `1` = confirmed |

**Used by:** `SavingsScreen`, `ViewAllHistoryScreen`

---

### 21. GET `/api/parent/topup/get-detail-byId?id=`

Single saving transaction detail with full nested student record.

**Query params:** `id` (int, transaction ID)

**Note:** Returns 401 if the transaction doesn't belong to the authenticated parent's student.

**Used by:** `DetailPembayaranScreen`

---

## Screen → API Map

| Screen | File | APIs |
|--------|------|------|
| `FinanceScreen` | `finance_screen.dart` | #1 home-bill, L1 get-limit |
| `SchoolBillsScreen` | `school_bills_screen.dart` | #2 list-unpaid, #3 list-paid, #4 list-all-bill |
| `DetailTagihanScreen` | `detail_tagihan_screen.dart` | #5 get-detail |
| `BillPaymentDetailScreen` | `bill_payment_detail_screen.dart` | #5 get-detail, #12 download-invoice |
| `SelectPaymentScreen` / `PilihMetodeKeuanganScreen` | `select_payment_screen.dart`, `pilih_metode_keuangan_screen.dart` | #6 payment-methods, #13 detail-emoney, #16 pay-with-emoney |
| `BankTransferPaymentScreen` | `bank_transfer_payment_screen.dart` | #7 no-rekening, #9 submit-transfer, #9b transfer-confirmation |
| `VaPaymentScreen` | `va_payment_screen.dart` | #8 create-payment/:slug |
| `PaymentGatewayScreen` | `payment_gateway_screen.dart` | #8 create-payment/:slug |
| `PendingConfirmationScreen` | `pending_confirmation_screen.dart` | #9b transfer-confirmation, #10 cancel-transfer |
| `MultiSelectPaymentScreen` | `multi_select_payment_screen.dart` | #11 pay-multiple |
| `EmoneyScreen` | `emoney_screen.dart` | #13 detail-emoney, #14 history-emoney, #18b topup-transfer, #17 emoney-topup-confirmation, #17b emoney-edit-confirmation, #18 emoney-cancel-topup |
| `NominalEntryScreen` | `nominal_entry_screen.dart` | #18b topup-transfer |
| `ViewAllHistoryScreen` | `view_all_history_screen.dart` | #14 history-emoney, #20 topup get-list |
| `CanteenPaymentScreen` | `canteen_payment_screen.dart` | #15 detail-history-emoney (parses `list_item` field for canteen items) |
| `DetailPembayaranScreen` | `detail_pembayaran_screen.dart` | #15 detail-history-emoney, #21 topup get-detail-byId |
| `SavingsScreen` | `savings_screen.dart` | #19 detail-topup-student, #20 topup get-list |

---

## Type Mappings

### `BillStatusType` ← `status` field

| API value | Enum | Display |
|-----------|------|---------|
| `unpaid` | `BillStatusType.unpaid` | Belum Bayar |
| `paid` | `BillStatusType.paid` | Lunas |
| `pending` | `BillStatusType.pending` | Menunggu Konfirmasi |
| `installment` | `BillStatusType.installment` | Cicilan |
| `confirmed` | `BillStatusType.confirmed` | Dikonfirmasi |

### `BillCategoryType` ← `bill.type` field

| API value | Enum |
|-----------|------|
| `spp` | `BillCategoryType.spp` |
| `dpp` | `BillCategoryType.dpp` |
| `lainnya` | `BillCategoryType.lainnya` |

### `TransactionType` ← `topup[].transaction` field

| API value | Enum |
|-----------|------|
| `topup` | `TransactionType.kredit` |
| `cashout` | `TransactionType.debit` |

---

## Notes

- **No data layer yet.** `lib/features/finance/` has screens and domain types but no `data/` layer. All API integration is pending on the `integration-finance` branch.
- **Demo student ID:** Use `385` (ZAVIER AKTAM DZAKIAN) for all development/testing.
- **Balance format inconsistency.** Saving uses raw int for `amount` in history but formatted string for the balance header (`saldo_topup`). E-money uses formatted strings throughout including in history items (`amount: "-500.000"`). Plan for separate parsing per context.
- **`student_id` source.** Not in the JWT — needs to come from the parent profile or a separate student-list endpoint.
- **Signed S3 URLs.** `evidence_path` in paid bills returns a pre-signed S3 URL with a 24-hour expiry. Don't cache these.
- **`created_at` in e-money history** is a human-readable Indonesian string (`"5 Maret 2026, 16:18 WIB"`), not a parseable date. Use `date` field for any date logic.
- **Canteen has no dedicated endpoint.** `CanteenPaymentScreen` reuses `GET /bill/detail-history-emoney/:id`. Canteen transactions have `transaction == "canteen"` and a `list_item` field containing a formatted string like `"- Nasi Goreng (1) Rp. 15000\n- Es Teh (2) Rp. 5000\n"`. Parse by splitting on `\n`, then extracting item name (before `(`), quantity (inside `()`), and price (after `Rp. `).
- **Topup flow is 2-step.** `topup-transfer` creates a pending record, then `emoney-topup-confirmation` uploads the proof photo. The response from `topup-transfer` includes bank details for the parent to transfer to.
