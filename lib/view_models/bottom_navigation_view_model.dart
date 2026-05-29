import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/states/bottom_navigation_state.dart';

class BottomNavigationViewModel extends Notifier<BottomNavigationState> {
  @override
  BottomNavigationState build() => const BottomNavigationState();

  void setIndex(int index) => state = state.copyWith(currentIndex: index);
}

final bottomNavigationProvider =
    NotifierProvider<BottomNavigationViewModel, BottomNavigationState>(
      BottomNavigationViewModel.new,
    );
