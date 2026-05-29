import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/states/profile_state.dart';

class ProfileViewModel extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    _load();
    return const ProfileState(isLoading: true);
  }

  Future<void> _load() async {
    await Future.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(
      isLoading: false,
      name: 'John Doe',
      email: 'john@example.com',
      phone: '+977 9800000000',
    );
  }

  void toggleEditing() => state = state.copyWith(isEditing: !state.isEditing);

  Future<void> saveProfile({
    required String name,
    required String email,
    required String phone,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      state = state.copyWith(
        isLoading: false,
        isEditing: false,
        name: name,
        email: email,
        phone: phone,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to save profile. Please try again.',
      );
    }
  }
}

final profileProvider = NotifierProvider<ProfileViewModel, ProfileState>(
  ProfileViewModel.new,
);
