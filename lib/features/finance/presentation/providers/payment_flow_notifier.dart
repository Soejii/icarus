import 'package:icarus/features/finance/domain/entities/bill_transaction_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_flow_notifier.g.dart';

class PaymentFlowState {
  const PaymentFlowState({
    this.selectedBill,
    this.selectedBills = const [],
    this.nominalAmount,
    this.notes,
    this.proofImagePath,
    this.vaNumber,
    this.redirectUrl,
    this.paymentMethod,
  });

  final BillTransactionEntity? selectedBill;
  final List<BillTransactionEntity> selectedBills;
  final int? nominalAmount;
  final String? notes;
  final String? proofImagePath;
  final String? vaNumber;
  final String? redirectUrl;
  final String? paymentMethod;

  PaymentFlowState copyWith({
    BillTransactionEntity? selectedBill,
    List<BillTransactionEntity>? selectedBills,
    int? nominalAmount,
    String? notes,
    String? proofImagePath,
    String? vaNumber,
    String? redirectUrl,
    String? paymentMethod,
  }) {
    return PaymentFlowState(
      selectedBill: selectedBill ?? this.selectedBill,
      selectedBills: selectedBills ?? this.selectedBills,
      nominalAmount: nominalAmount ?? this.nominalAmount,
      notes: notes ?? this.notes,
      proofImagePath: proofImagePath ?? this.proofImagePath,
      vaNumber: vaNumber ?? this.vaNumber,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }
}

@Riverpod(keepAlive: true)
class PaymentFlowNotifier extends _$PaymentFlowNotifier {
  @override
  PaymentFlowState build() => const PaymentFlowState();

  void selectBill(BillTransactionEntity bill) {
    state = state.copyWith(selectedBill: bill);
  }

  void setSelectedBills(List<BillTransactionEntity> bills) {
    state = state.copyWith(selectedBills: bills);
  }

  void setNominal(int amount, {String? notes}) {
    state = PaymentFlowState(
      selectedBill: state.selectedBill,
      selectedBills: state.selectedBills,
      nominalAmount: amount,
      notes: notes,
      proofImagePath: state.proofImagePath,
      vaNumber: state.vaNumber,
      redirectUrl: state.redirectUrl,
      paymentMethod: state.paymentMethod,
    );
  }

  void setProof(String imagePath) {
    state = state.copyWith(proofImagePath: imagePath);
  }

  void setVaNumber(String va) {
    state = state.copyWith(vaNumber: va);
  }

  void setRedirectUrl(String url) {
    state = state.copyWith(redirectUrl: url);
  }

  void setPaymentMethod(String slug) {
    state = state.copyWith(paymentMethod: slug);
  }

  void clear() {
    state = const PaymentFlowState();
  }

  int get effectiveAmount {
    final bill = state.selectedBill;
    if (bill == null) return 0;
    return state.nominalAmount ?? bill.billAmount;
  }
}
