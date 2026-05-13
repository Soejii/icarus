class BankTransferInfoEntity {
  final String? bankLogo;
  final String bankAccount;
  final String bankName;
  final String bankNumber;
  final int adminFeeSpp;
  final int adminFeeDpp;
  final int adminFeeLainnya;
  final int adminFeeEmoney;

  BankTransferInfoEntity({
    required this.bankLogo,
    required this.bankAccount,
    required this.bankName,
    required this.bankNumber,
    required this.adminFeeSpp,
    required this.adminFeeDpp,
    required this.adminFeeLainnya,
    required this.adminFeeEmoney,
  });
}
