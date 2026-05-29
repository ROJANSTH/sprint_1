enum OrderFilter { all, active, completed, cancelled }

class OrderHistoryState {
  const OrderHistoryState({
    this.isLoading = false,
    this.selectedFilter = OrderFilter.all,
    this.errorMessage,
  });

  final bool isLoading;
  final OrderFilter selectedFilter;
  final String? errorMessage;

  OrderHistoryState copyWith({
    bool? isLoading,
    OrderFilter? selectedFilter,
    String? errorMessage,
  }) => OrderHistoryState(
    isLoading: isLoading ?? this.isLoading,
    selectedFilter: selectedFilter ?? this.selectedFilter,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
