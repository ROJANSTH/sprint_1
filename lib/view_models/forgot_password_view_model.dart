import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/states/forgot_password_state.dart';

class ForgotPasswordViewModel extends Notifier<ForgotPasswordState> {
  @override
  ForgotPasswordState build() => const ForgotPasswordState();

  Future<void> sendResetEmail(String email) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(isLoading: false, isEmailSent: true);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to send reset email. Please try again.',
      );
    }
  }

  void reset() => state = const ForgotPasswordState();
}

final forgotPasswordProvider =
    NotifierProvider<ForgotPasswordViewModel, ForgotPasswordState>(
      ForgotPasswordViewModel.new,
    );
