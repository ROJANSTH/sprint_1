import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint_1/theme/my_theme.dart';
import 'package:sprint_1/view/login_view.dart';
import 'package:sprint_1/view_models/profile_view_model.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.h3),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(state.isEditing ? Icons.close : Icons.edit_outlined),
            onPressed: notifier.toggleEditing,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // ── Avatar ────────────────────────────────────────────────────
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 52,
                    color: AppColors.primary,
                  ),
                ),
                if (state.isEditing)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 14,
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            Text(state.name, style: AppTextStyles.h3),
            Text(state.email, style: AppTextStyles.bodySmall),

            const SizedBox(height: 28),

            // ── Info card ─────────────────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.person_outline,
                      label: 'Full Name',
                      value: state.name,
                      isEditing: state.isEditing,
                    ),
                    const Divider(height: 24),
                    _InfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: state.email,
                      isEditing: state.isEditing,
                    ),
                    const Divider(height: 24),
                    _InfoRow(
                      icon: Icons.phone_outlined,
                      label: 'Phone',
                      value: state.phone,
                      isEditing: state.isEditing,
                    ),
                  ],
                ),
              ),
            ),

            if (state.isEditing) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => notifier.saveProfile(
                    name: state.name,
                    email: state.email,
                    phone: state.phone,
                  ),
                  child: const Text('Save Changes'),
                ),
              ),
            ],

            const SizedBox(height: 28),

            // ── Menu items ────────────────────────────────────────────────
            Card(
              child: Column(
                children: [
                  _MenuItem(
                    icon: Icons.history_outlined,
                    label: 'Booking History',
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 52),
                  _MenuItem(
                    icon: Icons.favorite_border_outlined,
                    label: 'Saved Hostels',
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 52),
                  _MenuItem(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 52),
                  _MenuItem(
                    icon: Icons.help_outline,
                    label: 'Help & Support',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Logout ────────────────────────────────────────────────────
            Card(
              child: _MenuItem(
                icon: Icons.logout,
                label: 'Log Out',
                iconColor: AppColors.error,
                labelColor: AppColors.error,
                onTap: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                  (_) => false,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INFO ROW
// ─────────────────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.isEditing,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: isEditing
              ? TextFormField(
                  initialValue: value,
                  style: AppTextStyles.bodyMedium,
                  decoration: InputDecoration(
                    labelText: label,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: AppTextStyles.labelSmall),
                    const SizedBox(height: 2),
                    Text(value, style: AppTextStyles.bodyMedium),
                  ],
                ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MENU ITEM
// ─────────────────────────────────────────────────────────────────────────────

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: iconColor ?? AppColors.textSecondary,
        size: 22,
      ),
      title: Text(
        label,
        style: AppTextStyles.bodyMedium.copyWith(
          color: labelColor ?? AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: iconColor ?? AppColors.textHint,
        size: 20,
      ),
    );
  }
}
