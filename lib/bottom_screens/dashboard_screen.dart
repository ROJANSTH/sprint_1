import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/bottom_screens/home_screen.dart';
import 'package:sprint_1/bottom_screens/profile_screen.dart';
import 'package:sprint_1/bottom_screens/recent_screen.dart';
import 'package:sprint_1/theme/my_theme.dart';
import 'package:sprint_1/view_models/bottom_navigation_view_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SCREENS LIST
// ─────────────────────────────────────────────────────────────────────────────

const _screens = [
  HomeScreen(),
  _PlaceholderScreen(label: 'Search'),
  _PlaceholderScreen(label: 'Favorites'),
  RecentScreen(),
  ProfileScreen(),
];

// ─────────────────────────────────────────────────────────────────────────────
// DASHBOARD SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bottomNavigationProvider);
    final notifier = ref.read(bottomNavigationProvider.notifier);

    return Scaffold(
      body: IndexedStack(index: state.currentIndex, children: _screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: state.currentIndex,
        onDestinationSelected: notifier.setIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_outlined),
            selectedIcon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_outlined),
            selectedIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Bookings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PLACEHOLDER (Search & Favorites — build out later)
// ─────────────────────────────────────────────────────────────────────────────

class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(label)),
      body: Center(child: Text(label, style: AppTextStyles.h3)),
    );
  }
}
