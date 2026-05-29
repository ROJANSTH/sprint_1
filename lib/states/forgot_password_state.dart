class ForgotPasswordState {
  const ForgotPasswordState({
    this.isLoading = false,
    this.isEmailSent = false,
    this.errorMessage,
  });

  final bool isLoading;
  final bool isEmailSent;
  final String? errorMessage;

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isEmailSent,
    String? errorMessage,
  }) => ForgotPasswordState(
    isLoading: isLoading ?? this.isLoading,
    isEmailSent: isEmailSent ?? this.isEmailSent,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
