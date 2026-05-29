class ProfileState {
  const ProfileState({
    this.isLoading = false,
    this.isEditing = false,
    this.name = '',
    this.email = '',
    this.phone = '',
    this.errorMessage,
  });

  final bool isLoading;
  final bool isEditing;
  final String name;
  final String email;
  final String phone;
  final String? errorMessage;

  ProfileState copyWith({
    bool? isLoading,
    bool? isEditing,
    String? name,
    String? email,
    String? phone,
    String? errorMessage,
  }) => ProfileState(
    isLoading: isLoading ?? this.isLoading,
    isEditing: isEditing ?? this.isEditing,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}
