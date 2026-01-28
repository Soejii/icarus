import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaia/features/balances/domain/entities/emoney_history_entity.dart' as emoney;
import 'package:gaia/features/balances/domain/entities/savings_history_entity.dart' as savings;
import 'package:gaia/features/balances/domain/type/transaction_type.dart';
import 'package:gaia/features/balances/domain/type/transaction_status.dart';
import 'package:gaia/features/balances/presentation/mappers/transaction_type_ui_mapper.dart';
import 'package:gaia/features/balances/presentation/mappers/transaction_status_ui_mapper.dart';
import 'package:gaia/features/balances/presentation/mappers/generic_transaction_ui_mapper.dart';
import 'package:intl/intl.dart';

class BalanceHistoryItemWidget extends StatelessWidget {
  final emoney.EmoneyHistoryEntity? emoneyItem;
  final savings.SavingsHistoryEntity? savingsItem;

  const BalanceHistoryItemWidget.emoney({
    super.key,
    required this.emoneyItem,
  }) : savingsItem = null;

  const BalanceHistoryItemWidget.savings({
    super.key,
    required this.savingsItem,
  }) : emoneyItem = null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          SvgPicture.asset(
            _getIconAsset(),
            width: 25.w,
            height: 25.h,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getTransactionTitle(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: _getTitleColor(),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  _formatDate(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${_formatTime()} WIB',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color:  Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _formatAmount(),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: _getAmountColor(),
                ),
              ),
              SizedBox(height: 4.h),
              if (_shouldShowStatus())
                Text(
                  _getStatusText(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: _getStatusColor(),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _getIconAsset() {
    if (emoneyItem != null) {
      return TransactionTypeUIMapper.getIconAsset(
          emoneyItem?.transactionType ?? TransactionType.unknown);
    }
    return GenericTransactionUIMapper.getSavingsIconAsset(
        savingsItem?.type ?? TransactionType.unknown);
  }

  String _getTransactionTitle() {
    if (emoneyItem != null) {
      return TransactionTypeUIMapper.getDisplayText(
          emoneyItem?.transactionType ?? TransactionType.unknown);
    }
    return GenericTransactionUIMapper.getSavingsDisplayText(
        savingsItem?.type ?? TransactionType.unknown);
  }

  Color _getTitleColor() {
    if (emoneyItem != null) {
      return TransactionTypeUIMapper.getAmountColor(
          emoneyItem?.transactionType ?? TransactionType.unknown);
    }
    return GenericTransactionUIMapper.getSavingsAmountColor(
        savingsItem?.type ?? TransactionType.unknown);
  }

  String _formatDate() {
    final dateStr = emoneyItem?.date ?? savingsItem?.date;
    if (dateStr == null || dateStr.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  String _formatTime() {
    final dateStr = emoneyItem?.date ?? savingsItem?.date;
    if (dateStr == null || dateStr.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('HH:mm').format(date);
    } catch (e) {
      return '-';
    }
  }

  String _formatAmount() {
    if (emoneyItem != null) {
      final amount = emoneyItem?.amount;
      if (amount == null || amount.isEmpty) {
        return '0';
      }
      return amount;
    } else {
      final amount = savingsItem?.amount;
      if (amount == null) {
        return '0';
      }
      final type = savingsItem?.type ?? TransactionType.unknown;
      final prefix = type == TransactionType.topup ? '+' : '-';
      final formatter = NumberFormat('#,###', 'id_ID');
      final formattedAmount = formatter.format(amount);

      return '$prefix$formattedAmount';
    }
  }

  Color _getAmountColor() {
    if (emoneyItem != null) {
      return TransactionTypeUIMapper.getAmountColor(
          emoneyItem?.transactionType ?? TransactionType.unknown);
    }
    return GenericTransactionUIMapper.getSavingsAmountColor(
        savingsItem?.type ?? TransactionType.unknown);
  }

  bool _shouldShowStatus() {
    return emoneyItem != null;
  }

  String _getStatusText() {
    if (emoneyItem != null) {
      return TransactionStatusUIMapper.getDisplayText(
          emoneyItem?.status ?? TransactionStatus.unknown);
    }
    return '';
  }

  Color _getStatusColor() {
    if (emoneyItem != null) {
      return TransactionStatusUIMapper.getDisplayColor(
          emoneyItem?.status ?? TransactionStatus.unknown);
    }
    return Colors.grey;
  }
}
