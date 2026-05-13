import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icarus/features/finance/data/bill_repository_impl.dart';
import 'package:icarus/features/finance/data/datasource/bill_remote_data_source.dart';
import 'package:icarus/features/finance/data/datasource/emoney_remote_data_source.dart';
import 'package:icarus/features/finance/data/datasource/saving_remote_data_source.dart';
import 'package:icarus/features/finance/data/emoney_repository_impl.dart';
import 'package:icarus/features/finance/data/saving_repository_impl.dart';
import 'package:icarus/features/finance/domain/repositories/bill_repository.dart';
import 'package:icarus/features/finance/domain/repositories/emoney_repository.dart';
import 'package:icarus/features/finance/domain/repositories/saving_repository.dart';
import 'package:icarus/features/finance/domain/usecases/cancel_emoney_topup_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/cancel_transfer_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/confirm_emoney_topup_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/confirm_transfer_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/create_payment_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/edit_emoney_confirmation_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_bank_transfer_info_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_bill_detail_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_emoney_detail_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_emoney_history_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_emoney_transaction_detail_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_home_bill_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_list_paid_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_list_unpaid_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_payment_methods_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_saving_detail_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_saving_history_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_saving_transaction_detail_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/get_spending_limit_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/pay_multiple_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/pay_with_emoney_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/set_spending_limit_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/submit_transfer_usecase.dart';
import 'package:icarus/features/finance/domain/usecases/topup_transfer_usecase.dart';
import 'package:icarus/shared/core/infrastructure/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'finance_providers.g.dart';

// ── Datasources ──────────────────────────────────────────────────────────────

@riverpod
BillRemoteDataSource billRemoteDataSource(Ref ref) =>
    BillRemoteDataSource(ref.watch(dioProvider));

@riverpod
EmoneyRemoteDataSource emoneyRemoteDataSource(Ref ref) =>
    EmoneyRemoteDataSource(ref.watch(dioProvider));

@riverpod
SavingRemoteDataSource savingRemoteDataSource(Ref ref) =>
    SavingRemoteDataSource(ref.watch(dioProvider));

// ── Repositories ─────────────────────────────────────────────────────────────

@riverpod
BillRepository billRepository(Ref ref) =>
    BillRepositoryImpl(ref.watch(billRemoteDataSourceProvider));

@riverpod
EmoneyRepository emoneyRepository(Ref ref) =>
    EmoneyRepositoryImpl(ref.watch(emoneyRemoteDataSourceProvider));

@riverpod
SavingRepository savingRepository(Ref ref) =>
    SavingRepositoryImpl(ref.watch(savingRemoteDataSourceProvider));

// ── Bill use cases ────────────────────────────────────────────────────────────

@riverpod
GetHomeBillUsecase getHomeBillUsecase(Ref ref) =>
    GetHomeBillUsecase(ref.watch(billRepositoryProvider));

@riverpod
GetListUnpaidUsecase getListUnpaidUsecase(Ref ref) =>
    GetListUnpaidUsecase(ref.watch(billRepositoryProvider));

@riverpod
GetListPaidUsecase getListPaidUsecase(Ref ref) =>
    GetListPaidUsecase(ref.watch(billRepositoryProvider));

@riverpod
GetBillDetailUsecase getBillDetailUsecase(Ref ref) =>
    GetBillDetailUsecase(ref.watch(billRepositoryProvider));

@riverpod
GetPaymentMethodsUsecase getPaymentMethodsUsecase(Ref ref) =>
    GetPaymentMethodsUsecase(ref.watch(billRepositoryProvider));

@riverpod
GetBankTransferInfoUsecase getBankTransferInfoUsecase(Ref ref) =>
    GetBankTransferInfoUsecase(ref.watch(billRepositoryProvider));

@riverpod
CreatePaymentUsecase createPaymentUsecase(Ref ref) =>
    CreatePaymentUsecase(ref.watch(billRepositoryProvider));

@riverpod
SubmitTransferUsecase submitTransferUsecase(Ref ref) =>
    SubmitTransferUsecase(ref.watch(billRepositoryProvider));

@riverpod
ConfirmTransferUsecase confirmTransferUsecase(Ref ref) =>
    ConfirmTransferUsecase(ref.watch(billRepositoryProvider));

@riverpod
CancelTransferUsecase cancelTransferUsecase(Ref ref) =>
    CancelTransferUsecase(ref.watch(billRepositoryProvider));

@riverpod
PayMultipleUsecase payMultipleUsecase(Ref ref) =>
    PayMultipleUsecase(ref.watch(billRepositoryProvider));

@riverpod
PayWithEmoneyUsecase payWithEmoneyUsecase(Ref ref) =>
    PayWithEmoneyUsecase(ref.watch(billRepositoryProvider));

// ── Emoney use cases ──────────────────────────────────────────────────────────

@riverpod
GetEmoneyDetailUsecase getEmoneyDetailUsecase(Ref ref) =>
    GetEmoneyDetailUsecase(ref.watch(emoneyRepositoryProvider));

@riverpod
GetEmoneyHistoryUsecase getEmoneyHistoryUsecase(Ref ref) =>
    GetEmoneyHistoryUsecase(ref.watch(emoneyRepositoryProvider));

@riverpod
GetEmoneyTransactionDetailUsecase getEmoneyTransactionDetailUsecase(Ref ref) =>
    GetEmoneyTransactionDetailUsecase(ref.watch(emoneyRepositoryProvider));

@riverpod
TopupTransferUsecase topupTransferUsecase(Ref ref) =>
    TopupTransferUsecase(ref.watch(emoneyRepositoryProvider));

@riverpod
ConfirmEmoneyTopupUsecase confirmEmoneyTopupUsecase(Ref ref) =>
    ConfirmEmoneyTopupUsecase(ref.watch(emoneyRepositoryProvider));

@riverpod
EditEmoneyConfirmationUsecase editEmoneyConfirmationUsecase(Ref ref) =>
    EditEmoneyConfirmationUsecase(ref.watch(emoneyRepositoryProvider));

@riverpod
CancelEmoneyTopupUsecase cancelEmoneyTopupUsecase(Ref ref) =>
    CancelEmoneyTopupUsecase(ref.watch(emoneyRepositoryProvider));

// ── Saving use cases ──────────────────────────────────────────────────────────

@riverpod
GetSavingDetailUsecase getSavingDetailUsecase(Ref ref) =>
    GetSavingDetailUsecase(ref.watch(savingRepositoryProvider));

@riverpod
GetSavingHistoryUsecase getSavingHistoryUsecase(Ref ref) =>
    GetSavingHistoryUsecase(ref.watch(savingRepositoryProvider));

@riverpod
GetSavingTransactionDetailUsecase getSavingTransactionDetailUsecase(Ref ref) =>
    GetSavingTransactionDetailUsecase(ref.watch(savingRepositoryProvider));

@riverpod
GetSpendingLimitUsecase getSpendingLimitUsecase(Ref ref) =>
    GetSpendingLimitUsecase(ref.watch(savingRepositoryProvider));

@riverpod
SetSpendingLimitUsecase setSpendingLimitUsecase(Ref ref) =>
    SetSpendingLimitUsecase(ref.watch(savingRepositoryProvider));
