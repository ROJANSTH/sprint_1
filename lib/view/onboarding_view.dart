import 'package:flutter/material.dart';
import 'package:sprint_1/view/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _index = 0;

  static const List<_OnboardingPage> _pages = [
    _OnboardingPage(
      icon: Icons.apartment_rounded,
      title: 'Find Your Hostel',
      description:
          'Search and explore comfortable hostels near your preferred location easily.',
      color: Colors.deepPurple,
    ),

    _OnboardingPage(
      icon: Icons.bed_rounded,
      title: 'Book Rooms Easily',
      description:
          'Check room details, prices, and availability with a simple booking process.',
      color: Colors.indigo,
    ),

    _OnboardingPage(
      icon: Icons.security_rounded,
      title: 'Safe & Secure',
      description:
          'Your personal information and bookings are protected and secure.',
      color: Colors.purple,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginView()),
    );
  }

  Widget _dot(int i) {
    final selected = i == _index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: selected ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: selected ? Colors.deepPurple : Colors.grey.shade400,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  void _next() {
    if (_index == _pages.length - 1) {
      _goToLogin();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _index == _pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Column(
          children: [
            /// SKIP BUTTON
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 12, top: 8),
                child: TextButton(
                  onPressed: _goToLogin,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            /// PAGES
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) {
                  final page = _pages[i];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// ICON
                        Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            color: page.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(page.icon, size: 90, color: page.color),
                        ),

                        const SizedBox(height: 40),

                        /// TITLE
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// DESCRIPTION
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// DOTS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_dot(0), _dot(1), _dot(2)],
            ),

            /// BUTTON
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _next,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isLast ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
