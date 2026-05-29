class BottomNavigationState {
  const BottomNavigationState({this.currentIndex = 0});

  final int currentIndex;

  BottomNavigationState copyWith({int? currentIndex}) =>
      BottomNavigationState(currentIndex: currentIndex ?? this.currentIndex);
}
