enum TransactionType {
  kredit,
  debit,
}

extension TransactionTypeName on TransactionType {
  String get label => switch (this) {
        TransactionType.kredit => 'Kredit',
        TransactionType.debit => 'Debit',
      };
}
