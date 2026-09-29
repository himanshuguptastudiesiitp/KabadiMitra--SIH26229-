import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(I18n.t(lang, "pickRole"), style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              _RoleCard(
                title: I18n.t(lang, "roleCollector"),
                icon: Icons.pedal_bike,
                selected: store.role == UserRole.collector,
                onTap: () => store.setRole(UserRole.collector),
              ),
              const SizedBox(height: 10),
              _RoleCard(
                title: I18n.t(lang, "roleRecycler"),
                icon: Icons.store,
                selected: store.role == UserRole.recycler,
                onTap: () => store.setRole(UserRole.recycler),
              ),
              const SizedBox(height: 10),
              _RoleCard(
                title: I18n.t(lang, "roleAdmin"),
                icon: Icons.admin_panel_settings,
                selected: store.role == UserRole.admin,
                onTap: () => store.setRole(UserRole.admin),
              ),
              const Spacer(),
              BigButton(
                label: I18n.t(lang, "next"),
                onPressed: () {
                  store.completeOnboarding();
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;
  const _RoleCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: selected ? AppColors.primary : AppColors.muted, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: selected ? AppColors.primary : null,
              ),
            ),
          ),
          if (selected) const Icon(Icons.check_circle, color: AppColors.primary),
        ],
      ),
    );
  }
}
