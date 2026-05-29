class HomeState {
  const HomeState({
    this.isLoading = false,
    this.searchQuery = '',
    this.selectedCategory = 'All',
    this.errorMessage,
  });

  final bool isLoading;
  final String searchQuery;
  final String selectedCategory;
  final String? errorMessage;

  HomeState copyWith({
    bool? isLoading,
    String? searchQuery,
    String? selectedCategory,
    String? errorMessage,
  }) => HomeState(
    isLoading: isLoading ?? this.isLoading,
    searchQuery: searchQuery ?? this.searchQuery,
    selectedCategory: selectedCategory ?? this.selectedCategory,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
