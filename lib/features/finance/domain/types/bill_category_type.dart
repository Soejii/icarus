enum BillCategoryType {
  spp,
  dpp,
  lainnya,
}

extension BillCategoryName on BillCategoryType {
  String get label => switch (this) {
        BillCategoryType.spp => 'SPP',
        BillCategoryType.dpp => 'DPP',
        BillCategoryType.lainnya => 'Lainnya',
      };
}

const billCategories = [
  BillCategoryType.spp,
  BillCategoryType.dpp,
  BillCategoryType.lainnya,
];
