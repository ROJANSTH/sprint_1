import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/theme/my_theme.dart';
import 'package:sprint_1/view/onboarding_view.dart';

// ─────────────────────────────────────────────────────────────────────────────
// PROVIDER
// ─────────────────────────────────────────────────────────────────────────────

final splashProvider = FutureProvider<void>((ref) async {
  await Future.delayed(const Duration(seconds: 3));
});

// ─────────────────────────────────────────────────────────────────────────────
// VIEW
// ─────────────────────────────────────────────────────────────────────────────

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(splashProvider, (_, next) {
      if (next is AsyncData) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingView()),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Logo ────────────────────────────────────────────────────────
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.apartment_rounded,
                size: 65,
                color: AppColors.white,
              ),
            ),

            const SizedBox(height: 30),

            // ── App name ─────────────────────────────────────────────────────
            Text(
              'Hostel Booking',
              style: AppTextStyles.h1.copyWith(
                color: AppColors.white,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            // ── Subtitle ─────────────────────────────────────────────────────
            Text(
              'Find and book your perfect hostel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.white.withOpacity(0.75),
              ),
            ),

            const SizedBox(height: 50),

            // ── Loader ───────────────────────────────────────────────────────
            const CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
