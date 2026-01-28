import 'package:flutter/material.dart';
import 'package:gaia/features/balances/domain/type/balance_type.dart';
import 'package:gaia/shared/core/constant/assets_helper.dart';


class BalanceTypeUIMapper {
  static List<Color> getGradientColors(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return [const Color(0xFFFF7A00), const Color(0xFFFF9839)];
      case BalanceType.savings:
        return [const Color(0xFF197BBD), const Color(0xFF3391D0)];
    }
  }

  static String getIconAsset(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return AssetsHelper.icEmoney;
      case BalanceType.savings:
        return AssetsHelper.icSaving;
    }
  }

  static String getDisplayName(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return 'E-Money';
      case BalanceType.savings:
        return 'Tabungan Digital';
    }
  }

  static String getDefaultName(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return 'E-Money';
      case BalanceType.savings:
        return 'Tabungan Digital';
    }
  }

  static String getSubtitle(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return 'Digital Smart Card';
      case BalanceType.savings:
        return 'Kartu Pelajar Digital';
    }
  }

  static String getDefaultCardId(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return 'EMONEY-IDCARD';
      case BalanceType.savings:
        return 'SAVING-IDCARD';
    }
  }

  static String getDefaultUserName(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return 'E-Money User';
      case BalanceType.savings:
        return 'Tabungan User';
    }
  }

  static String getRouteParameter(BalanceType type) {
    switch (type) {
      case BalanceType.emoney:
        return 'emoney';
      case BalanceType.savings:
        return 'savings';
    }
  }
}
