import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/theme/my_theme.dart';
import 'package:sprint_1/view/dashboard_view.dart';
import 'package:sprint_1/view/signup_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATE
// ─────────────────────────────────────────────────────────────────────────────

class LoginState {
  const LoginState({this.obscurePassword = true, this.isLoading = false});

  final bool obscurePassword;
  final bool isLoading;

  LoginState copyWith({bool? obscurePassword, bool? isLoading}) => LoginState(
    obscurePassword: obscurePassword ?? this.obscurePassword,
    isLoading: isLoading ?? this.isLoading,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// NOTIFIER
// ─────────────────────────────────────────────────────────────────────────────

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState();

  void togglePassword() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);

  void setLoading(bool value) => state = state.copyWith(isLoading: value);
}

// ─────────────────────────────────────────────────────────────────────────────
// PROVIDER
// ─────────────────────────────────────────────────────────────────────────────

final loginProvider = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);

// ─────────────────────────────────────────────────────────────────────────────
// VIEW
// ─────────────────────────────────────────────────────────────────────────────

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);
    final notifier = ref.read(loginProvider.notifier);
    final formKey = GlobalKey<FormState>();
    final emailCtrl = TextEditingController();
    final passwordCtrl = TextEditingController();

    void login() {
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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ────────────────────────────────────────────────
                const SizedBox(height: 30),
                Center(
                  child: Column(
                    children: [
                      Text(
                        'HostelFinder',
                        style: AppTextStyles.h2.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Find cozy stays, meet travelers',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Hero image ────────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: 240,
                  child: Image.asset(
                    'assets/image/hostels.png',
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 28),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Email ──────────────────────────────────────────
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
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Please enter email'
                            : null,
                      ),

                      const SizedBox(height: 20),

                      // ── Password ───────────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Password', style: AppTextStyles.labelMedium),
                          TextButton(
                            onPressed: () {}, // TODO: forgot password
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
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
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'Please enter password'
                            : null,
                      ),

                      const SizedBox(height: 24),

                      // ── Login button ───────────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: state.isLoading ? null : login,
                          child: state.isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.white,
                                  ),
                                )
                              : const Text('Log In'),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Divider ────────────────────────────────────────
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'or continue with',
                              style: AppTextStyles.bodySmall,
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ── Social buttons ─────────────────────────────────
                      Row(
                        children: [
                          _SocialButton(
                            icon: Icons.g_mobiledata,
                            iconColor: Colors.red,
                            label: 'Google',
                            onTap: () {},
                          ),
                          const SizedBox(width: 14),
                          _SocialButton(
                            icon: Icons.facebook,
                            iconColor: Colors.indigo,
                            label: 'Facebook',
                            onTap: () {},
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Sign up link ───────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyles.bodySmall,
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignupView(),
                              ),
                            ),
                            child: Text(
                              'Sign up',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SOCIAL BUTTON WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.divider),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: iconColor, size: 26),
              const SizedBox(width: 6),
              Text(label, style: AppTextStyles.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
