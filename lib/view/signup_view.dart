import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/theme/my_theme.dart';
import 'package:sprint_1/view/dashboard_view.dart';
import 'package:sprint_1/view/login_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATE
// ─────────────────────────────────────────────────────────────────────────────

class SignupState {
  const SignupState({
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.agreeTerms = false,
    this.isLoading = false,
  });

  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool agreeTerms;
  final bool isLoading;

  SignupState copyWith({
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    bool? agreeTerms,
    bool? isLoading,
  }) => SignupState(
    obscurePassword: obscurePassword ?? this.obscurePassword,
    obscureConfirmPassword:
        obscureConfirmPassword ?? this.obscureConfirmPassword,
    agreeTerms: agreeTerms ?? this.agreeTerms,
    isLoading: isLoading ?? this.isLoading,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// NOTIFIER
// ─────────────────────────────────────────────────────────────────────────────

class SignupNotifier extends Notifier<SignupState> {
  @override
  SignupState build() => const SignupState();

  void togglePassword() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);

  void toggleConfirmPassword() => state = state.copyWith(
    obscureConfirmPassword: !state.obscureConfirmPassword,
  );

  void toggleAgreeTerms() =>
      state = state.copyWith(agreeTerms: !state.agreeTerms);

  void setLoading(bool value) => state = state.copyWith(isLoading: value);
}

// ─────────────────────────────────────────────────────────────────────────────
// PROVIDER
// ─────────────────────────────────────────────────────────────────────────────

final signupProvider = NotifierProvider<SignupNotifier, SignupState>(
  SignupNotifier.new,
);

// ─────────────────────────────────────────────────────────────────────────────
// VIEW
// ─────────────────────────────────────────────────────────────────────────────

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signupProvider);
    final notifier = ref.read(signupProvider.notifier);

    final formKey = GlobalKey<FormState>();
    final fullNameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();
    final confirmPasswordCtrl = TextEditingController();

    void signup() {
      if (!(state.agreeTerms)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to Terms & Conditions')),
        );
        return;
      }
      if (formKey.currentState?.validate() ?? false) {
        notifier.setLoading(true);
        // TODO: replace with real auth call
        Future.delayed(const Duration(milliseconds: 800), () {
          notifier.setLoading(false);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const DashboardView()),
          );
        });
      }
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // ── Title ──────────────────────────────────────────────────
                Text('Create Account', style: AppTextStyles.h1),
                const SizedBox(height: 6),
                Text('Sign up to get started', style: AppTextStyles.bodySmall),

                const SizedBox(height: 32),

                // ── Full Name ──────────────────────────────────────────────
                Text('Full Name', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: fullNameCtrl,
                  style: AppTextStyles.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: 'Enter your full name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Please enter full name'
                      : null,
                ),

                const SizedBox(height: 20),

                // ── Email ──────────────────────────────────────────────────
                Text('Email', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextStyles.bodyMedium,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Please enter email' : null,
                ),

                const SizedBox(height: 20),

                // ── Password ───────────────────────────────────────────────
                Text('Password', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passwordCtrl,
                  obscureText: state.obscurePassword,
                  style: AppTextStyles.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: notifier.togglePassword,
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'Please enter password' : null,
                ),

                const SizedBox(height: 20),

                // ── Confirm Password ───────────────────────────────────────
                Text('Confirm Password', style: AppTextStyles.labelMedium),
                const SizedBox(height: 8),
                TextFormField(
                  controller: confirmPasswordCtrl,
                  obscureText: state.obscureConfirmPassword,
                  style: AppTextStyles.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.textSecondary,
                      ),
                      onPressed: notifier.toggleConfirmPassword,
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty)
                      return 'Please confirm password';
                    if (v != passwordCtrl.text) return 'Passwords do not match';
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ── Terms ──────────────────────────────────────────────────
                Row(
                  children: [
                    Checkbox(
                      value: state.agreeTerms,
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (_) => notifier.toggleAgreeTerms(),
                    ),
                    Text('I agree to the ', style: AppTextStyles.bodySmall),
                    GestureDetector(
                      onTap: () {}, // TODO: open terms
                      child: Text(
                        'Terms & Conditions',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // ── Sign Up Button ─────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: state.isLoading ? null : signup,
                    child: state.isLoading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.white,
                            ),
                          )
                        : const Text('Sign Up'),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Login Link ─────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodySmall,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginView()),
                      ),
                      child: Text(
                        'Log In',
                        style: AppTextStyles.labelLarge.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
