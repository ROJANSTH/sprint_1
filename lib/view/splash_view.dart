import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sprint_1/view/onboarding_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6C4DF6),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// LOGO CONTAINER
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),

              child: const Icon(
                Icons.apartment_rounded,
                size: 65,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            /// APP NAME
            const Text(
              'Hostel Booking',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 10),

            /// SUBTITLE
            const Text(
              'Find and book your perfect hostel',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),

            const SizedBox(height: 50),

            /// LOADING INDICATOR
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}
