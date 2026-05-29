import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/states/order_history_state.dart';
import 'package:sprint_1/theme/my_theme.dart';
import 'package:sprint_1/view_models/order_history_view_model.dart';

class RecentScreen extends ConsumerWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(orderHistoryProvider);
    final notifier = ref.read(orderHistoryProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('My Bookings', style: AppTextStyles.h3),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // ── Filter tabs ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: OrderFilter.values.map((filter) {
                final selected = state.selectedFilter == filter;
                final label =
                    filter.name[0].toUpperCase() + filter.name.substring(1);
                return Expanded(
                  child: GestureDetector(
                    onTap: () => notifier.setFilter(filter),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.primary : AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selected
                              ? AppColors.primary
                              : AppColors.divider,
                        ),
                      ),
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: selected
                              ? AppColors.white
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // ── Content ────────────────────────────────────────────────────
          Expanded(
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: notifier.refresh,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: 5, // TODO: replace with real data
                      itemBuilder: (_, i) => _BookingCard(index: i),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// BOOKING CARD
// ─────────────────────────────────────────────────────────────────────────────

class _BookingCard extends StatelessWidget {
  const _BookingCard({required this.index});
  final int index;

  static const _statusColors = [
    AppColors.success,
    AppColors.warning,
    AppColors.error,
    AppColors.success,
    AppColors.primary,
  ];

  static const _statuses = [
    'Completed',
    'Active',
    'Cancelled',
    'Completed',
    'Active',
  ];

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColors[index % _statusColors.length];
    final status = _statuses[index % _statuses.length];

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.apartment_rounded,
                color: AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('The Adventure Hostel', style: AppTextStyles.h4),
                  const SizedBox(height: 4),
                  Text(
                    '12 May – 15 May · 1 Guest',
                    style: AppTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text('\$36', style: AppTextStyles.price),
          ],
        ),
      ),
    );
  }
}
