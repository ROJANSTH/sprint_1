import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/states/order_history_state.dart';

class OrderHistoryViewModel extends Notifier<OrderHistoryState> {
  @override
  OrderHistoryState build() {
    _load();
    return const OrderHistoryState(isLoading: true);
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(isLoading: false);
  }

  void setFilter(OrderFilter filter) =>
      state = state.copyWith(selectedFilter: filter);

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _load();
  }
}

final orderHistoryProvider =
    NotifierProvider<OrderHistoryViewModel, OrderHistoryState>(
      OrderHistoryViewModel.new,
    );
