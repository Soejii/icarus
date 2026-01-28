class Paged<T> {
  final List<T> items;
  final int page;
  final bool hasMore;
  final bool isFirstLoading;
  final bool isMoreLoading;
  final Object? error;

  const Paged({
    this.items = const [],
    this.page = 1,
    this.hasMore = true,
    this.isFirstLoading = true,
    this.isMoreLoading = false,
    this.error,
  });

  Paged<T> copyWith({
    List<T>? items,
    int? page,
    bool? hasMore,
    bool? isFirstLoading,
    bool? isMoreLoading,
    Object? error,
  }) {
    return Paged<T>(
      items: items ?? this.items,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isFirstLoading: isFirstLoading ?? this.isFirstLoading,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
      error: error,
    );
  }
}
