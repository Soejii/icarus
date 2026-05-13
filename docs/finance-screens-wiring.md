# Finance Screens Wiring Guide

Reference for wiring the finance feature's UI layer to the data layer.
The data layer (datasources, models, mappers, entities, repos, usecases, providers) is complete.
This doc covers what each screen needs and how the payment flow passes state between screens.

---

## Current Status

| Screen | Wired? | Notes |
|--------|--------|-------|
| `EmoneyScreen` | ✅ | Real providers, infinite scroll |
| `SavingsScreen` | ✅ | Real providers, infinite scroll |
| `ViewAllHistoryScreen` | ✅ | Real providers, infinite scroll |
| `FinanceScreen` | ❌ | Delegates to 4 widgets, all mock |
| `SchoolBillsScreen` | ❌ | `BillListContentWidget` uses mock data |
| `DetailTagihanScreen` | ❌ | Fully hardcoded mock |
| `SelectPaymentScreen` | ❌ | Hardcoded `_methods` list |
| `BillPaymentDetailScreen` | ❌ | Delegates to mock widgets |
| `BankTransferPaymentScreen` | ❌ | Hardcoded bank info, no POST |
| `VaPaymentScreen` | ❌ | Hardcoded VA number, no POST |
| `NominalEntryScreen` | ❌ | Hardcoded bill name |
| `MultiSelectPaymentScreen` | ❌ | `_buildMockData()` hardcoded |
| `PaymentGatewayScreen` | ❌ | TODO comment on Lanjutkan button |
| `PendingConfirmationScreen` | ❌ | Shows nothing real |
| `TransactionSuccessScreen` | ❌ | Shows nothing real |
| `CanteenPaymentScreen` | ❌ | Hardcoded canteen items |
| `DetailPembayaranScreen` | ❌ | Fully hardcoded |
| `PilihMetodeKeuanganScreen` | ✅ | Navigation only, no data needed |

---

## Navigation Flow

```
FinanceScreen
├── → SchoolBillsScreen                  (Pembayaran Sekolah)
│     └── BillListContentWidget(category)
│           ├── [unpaid tap] → DetailTagihanScreen
│           │     └── [Bayar Tagihan]
│           │           ├── if installment → NominalEntryScreen
│           │           │     └── → BillPaymentDetailScreen
│           │           │           └── → SelectPaymentScreen
│           │           └── else → SelectPaymentScreen
│           │                 ├── transfer-bank → BankTransferPaymentScreen → PendingConfirmationScreen → FinanceScreen
│           │                 ├── va-bni/bmi  → VaPaymentScreen → PendingConfirmationScreen → FinanceScreen
│           │                 ├── winpay      → PaymentGatewayScreen → (webview) → FinanceScreen
│           │                 └── emoney      → PendingConfirmationScreen → FinanceScreen
│           └── [paid tap] → DetailPembayaranScreen
│
├── → PilihMetodeKeuanganScreen           (Bayar Tagihan button)
│     ├── → SchoolBillsScreen             (Bayar Tagihan - single)
│     └── → MultiSelectPaymentScreen     (Bayar Banyak Tagihan)
│           └── [Lanjutkan] → SelectPaymentScreen → ...
│
├── → EmoneyScreen
│     └── [Top Up] → NominalEntryScreen  (top-up flow, different from bill payment)
│
├── → SavingsScreen
└── → CanteenPaymentScreen               (from emoney transaction detail)
```

---

## Data Passing Strategy: PaymentFlowNotifier

All payment-flow screens have **const constructors with no params** and the router doesn't pass any data for them. State must travel via a shared Riverpod provider.

### `PaymentFlowState` + `PaymentFlowNotifier`

File: `lib/features/finance/presentation/providers/payment_flow_notifier.dart`

```dart
class PaymentFlowState {
  // Which bill is being paid (set when tapping a bill in BillListContentWidget)
  final BillTransactionEntity? selectedBill;
  
  // Payment inputs
  final int? nominalAmount;      // For installment (NominalEntryScreen)
  final String? notes;           // Optional payment notes
  final String? proofImagePath;  // Uploaded bank transfer proof (XFile path)
  
  // Result of createPayment POST (populated after API call)
  final String? vaNumber;        // VA payment
  final String? redirectUrl;     // Winpay payment gateway
  final int? transferId;         // Bank transfer transaction ID
  
  // E-money canteen flow
  final int? emoneyTransactionId;
}
```

### Setting selected bill (BillListContentWidget)

```dart
// When tapping unpaid bill:
ref.read(paymentFlowNotifierProvider.notifier).selectBill(bill);
context.pushNamed(RouteName.detailTagihan);

// When tapping paid bill:
ref.read(paymentFlowNotifierProvider.notifier).selectBill(bill);
context.pushNamed(RouteName.detailPembayaran);
```

### Clearing state

Clear `PaymentFlowState` when:
- User taps "Kembali ke Keuangan" on PendingConfirmationScreen or TransactionSuccessScreen
- User taps back from SelectPaymentScreen up to SchoolBillsScreen

---

## Per-Screen Wiring Details

### FinanceScreen widgets

`FinanceScreen` itself is fine — it delegates to 4 widgets. Wire those widgets:

| Widget | Provider | Action |
|--------|----------|--------|
| `FinanceBalanceRowWidget` | `emoneyDetailControllerProvider`, `savingDetailControllerProvider` | Display balances |
| `FinanceUnpaidSummaryWidget` | `homeBillControllerProvider` | Display unpaid totals |
| `FinancePocketLimitWidget` | `spendingLimitControllerProvider` | Load + save spending limit |
| `FinanceNavSectionWidget` | None | Navigation only |

**`FinanceBalanceRowWidget`**: Change to `ConsumerWidget`, watch both detail providers.

**`FinanceUnpaidSummaryWidget`**: Change to `ConsumerWidget`, watch `homeBillControllerProvider`. Show `homeBill.unpaidTotal`, `unpaidSpp`, `unpaidDpp`, `unpaidLainnya`.

**`FinancePocketLimitWidget`**: Change to `ConsumerStatefulWidget` (already `StatefulWidget`). Watch `spendingLimitControllerProvider` to load current limit. Wire "Simpan" to `ref.read(spendingLimitControllerProvider.notifier).setLimit(...)`.

### BillListContentWidget

Replace `_mockUnpaidBills()` and `_mockPaidGroups()` with:

```dart
// Unpaid:
final unpaid = ref.watch(schoolBillsControllerProvider(category));
// Paid (with pagination):
final paid = ref.watch(schoolBillsPaidControllerProvider(category));
```

When tapping unpaid bill:
```dart
ref.read(paymentFlowNotifierProvider.notifier).selectBill(tx);
context.pushNamed(RouteName.detailTagihan);
```

### DetailTagihanScreen

Replace hardcoded mock with:
```dart
final bill = ref.watch(paymentFlowNotifierProvider).selectedBill;
// Or fetch full detail:
final detail = ref.watch(billDetailControllerProvider(bill!.id));
```

### SelectPaymentScreen

Replace hardcoded `_methods` list:
```dart
final methods = ref.watch(paymentMethodsControllerProvider);
final emoney = ref.watch(emoneyDetailControllerProvider);
// Show real payment methods from API
// Show real emoney balance in subtitle
```

On "Lanjutkan":
```dart
ref.read(paymentFlowNotifierProvider.notifier).selectPaymentMethod(selectedSlug);
switch (selectedSlug) { ... } // navigate as before
```

### BankTransferPaymentScreen

Fetch bank info:
```dart
final bankInfo = ref.watch(bankTransferInfoControllerProvider);
// Show bankInfo.bankName, bankInfo.bankNumber, bankInfo.bankLogo
// Show total = selectedBill.billAmount + bankInfo.adminFeeSpp (or Dpp/Lainnya)
```

On "Saya Sudah Transfer":
```dart
final result = await ref.read(paymentActionControllerProvider.notifier)
    .submitTransfer(
      billTrxId: bill.id,
      amount: paymentAmount,
      imagePath: selectedImage.value!.path,
    );
result.fold(
  (failure) => showSnackBar(failure.message),
  (_) => context.pushNamed(RouteName.pendingConfirmation),
);
```

### VaPaymentScreen

On screen init, call `createPayment` to generate the VA:
```dart
@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) => _createVa());
}

Future<void> _createVa() async {
  final bill = ref.read(paymentFlowNotifierProvider).selectedBill!;
  final result = await ref.read(paymentActionControllerProvider.notifier)
      .createPayment(bankType.slug, bill.id, ...);
  result.fold(
    (f) => showError(f),
    (data) => ref.read(paymentFlowNotifierProvider.notifier).setVaNumber(data['virtual_account']),
  );
}
```

### PaymentGatewayScreen

On "Lanjutkan ke Pembayaran":
```dart
final result = await ref.read(paymentActionControllerProvider.notifier)
    .createPayment('winpay', bill.id, ...);
result.fold(
  (f) => showError(f),
  (data) => launchUrl(Uri.parse(data['redirect_url'])),
);
```

### MultiSelectPaymentScreen

Replace `_buildMockData()`:
```dart
final sppBills = ref.watch(schoolBillsControllerProvider(BillCategoryType.spp));
final dppBills = ref.watch(schoolBillsControllerProvider(BillCategoryType.dpp));
final lainnyaBills = ref.watch(schoolBillsControllerProvider(BillCategoryType.lainnya));
```

On "Lanjutkan":
```dart
ref.read(paymentFlowNotifierProvider.notifier).setSelectedBills(checkedBills);
context.pushNamed(RouteName.selectPayment);
```

Payment: calls `payMultiple` POST.

### PendingConfirmationScreen + TransactionSuccessScreen

Read from PaymentFlowNotifier to populate `TransactionDetailSummaryWidget` and `UploadedPhotoWidget`.

---

## Provider Quick Reference

| Provider | What it gives |
|----------|--------------|
| `homeBillControllerProvider` | `HomeBillEntity` (unpaid totals, student info) |
| `spendingLimitControllerProvider` | `SpendingLimitEntity` (type + amount) |
| `schoolBillsControllerProvider(BillCategoryType)` | `List<BillTransactionEntity>` (unpaid) |
| `billDetailControllerProvider(int)` | `BillDetailEntity` (full detail + installments) |
| `paymentMethodsControllerProvider` | `List<PaymentMethodEntity>` |
| `bankTransferInfoControllerProvider` (TODO) | `BankTransferInfoEntity` |
| `emoneyDetailControllerProvider` | `EmoneyDetailEntity` |
| `savingDetailControllerProvider` | `SavingDetailEntity` |
| `paymentActionControllerProvider` | POST operations |
| `paymentFlowNotifierProvider` | In-flight payment state (new) |

---

## Missing: SchoolBillsPaid Controller

The current `SchoolBillsController` only fetches unpaid bills. For the "Riwayat Tagihan" tab in `BillListContentWidget`, we need a paid bills list (with pagination). Options:
1. Add a `SchoolBillsPaidController` (family by `BillCategoryType`)
2. Or use `GetListPaidUsecase` directly in the widget

---

## Missing: BankTransferInfoController

A `bankTransferInfoControllerProvider` (keepAlive) that calls `GetBankTransferInfoUsecase`. This needs to be added to `finance_providers.dart` and a controller file.

---

## VaBankType ↔ Payment Method Slug Mapping

| `VaBankType` | API slug (from payment methods) |
|------------|-------------------------------|
| `VaBankType.bni` | `'va-bni'` |
| `VaBankType.bmi` | `'va-bmi'` |

The `VaBankType` enum already has `label`, `bankCode`, `adminFee`, `instructions` fields for the VA screen display.

---

## Hardcoded Colors to Fix

Several screens use raw hex colors that should use `context.brand.*`:
- `BankTransferPaymentScreen`: `Color(0xFFF5F5F5)` background
- `VaPaymentScreen`: `Color(0xFFF5F5F5)` background
- `PaymentGatewayScreen`: `Color(0xFFFFFBEB)`, `Color(0xFFFDE68A)`, `Color(0xFFD97706)`, `Color(0xFF92400E)` (warning box — these are intentional amber/warning colors, OK to keep as-is)
- `FinanceUnpaidSummaryWidget`: `Color(0xFFFF7171)` red text (intentional error color, OK)
