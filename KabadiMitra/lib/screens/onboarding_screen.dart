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
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(I18n.t(lang, "appName"), style: Theme.of(context).textTheme.headlineLarge),
            Text(I18n.t(lang, "chainSub"), style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Row(
              children: [
                _LangMini(Lang.hi, "हिंदी", store),
                const SizedBox(width: 8),
                _LangMini(Lang.mr, "मराठी", store),
                const SizedBox(width: 8),
                _LangMini(Lang.en, "EN", store),
              ],
            ),
            const SizedBox(height: 16),
            PipelineStrip(lang: lang, current: LotStatusLike.collected),
            const SizedBox(height: 16),
            ...List.generate(8, (i) {
              const steps = [
                "step1",
                "step2",
                "step3",
                "step4",
                "step5",
                "step6",
                "step7",
                "step8",
              ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.primary,
                      child: Text("${i + 1}",
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(I18n.t(lang, steps[i]),
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 16),
            Text(I18n.t(lang, "pickRole"), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Row(
              children: [
                _RoleChip(UserRole.collector, I18n.t(lang, "roleCollector"), store),
                const SizedBox(width: 8),
                _RoleChip(UserRole.recycler, I18n.t(lang, "roleRecycler"), store),
                const SizedBox(width: 8),
                _RoleChip(UserRole.admin, I18n.t(lang, "roleAdmin"), store),
              ],
            ),
            const SizedBox(height: 24),
            BigButton(
              label: I18n.t(lang, "next"),
              onPressed: () {
                store.completeOnboarding();
                store.seedDemo();
                Navigator.pushReplacementNamed(context, "/home");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final UserRole role;
  final String label;
  final AppStore store;
  const _RoleChip(this.role, this.label, this.store);

  @override
  Widget build(BuildContext context) {
    final selected = store.role == role;
    return SelectChip(
      label: label,
      selected: selected,
      expanded: true,
      onTap: () => store.setRole(role),
    );
  }
}

class _LangMini extends StatelessWidget {
  final Lang lang;
  final String label;
  final AppStore store;
  const _LangMini(this.lang, this.label, this.store);

  @override
  Widget build(BuildContext context) {
    final on = store.language == lang;
    return SelectChip(
      label: label,
      selected: on,
      expanded: true,
      onTap: () => store.setLanguage(lang),
    );
  }
}
