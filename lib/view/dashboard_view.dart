import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sprint_1/view/login_view.dart';

// ─── Provider ────────────────────────────────────────────────────────────────

final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// ─── Tab pages ───────────────────────────────────────────────────────────────

class _TabPage extends StatelessWidget {
  const _TabPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ─── Tab configuration ───────────────────────────────────────────────────────

const _tabs = [
  (label: 'Home', icon: Icons.home_outlined, activeIcon: Icons.home),
  (label: 'Search', icon: Icons.search_outlined, activeIcon: Icons.search),
  (
    label: 'Favorites',
    icon: Icons.favorite_border_outlined,
    activeIcon: Icons.favorite,
  ),
  (label: 'Bookings', icon: Icons.book_outlined, activeIcon: Icons.book),
  (label: 'Profile', icon: Icons.person_outline, activeIcon: Icons.person),
];

// ─── Dashboard ───────────────────────────────────────────────────────────────

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  static const _primaryColor = Color(0xFF6C3BFF);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[currentIndex].label),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginView()),
              (_) => false,
            ),
          ),
        ],
      ),

      body: _TabPage(label: _tabs[currentIndex].label),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) =>
            ref.read(bottomNavIndexProvider.notifier).state = index,
        indicatorColor: _primaryColor.withOpacity(0.15),
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.activeIcon, color: _primaryColor),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}
