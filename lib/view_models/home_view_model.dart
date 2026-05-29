import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/states/home_state.dart';

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    _load();
    return const HomeState(isLoading: true);
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(isLoading: false);
  }

  void search(String query) => state = state.copyWith(searchQuery: query);

  void selectCategory(String category) =>
      state = state.copyWith(selectedCategory: category);

  Future<void> refresh() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    await _load();
  }
}

final homeProvider = NotifierProvider<HomeViewModel, HomeState>(
  HomeViewModel.new,
);
