import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AppStore>().language;
    const tips = [
      "Wear gloves when handling scrap.",
      "Avoid broken glass and sharp metal edges.",
      "Do not burn plastic or wires.",
      "Wash hands after work.",
      "Keep children away from scrap piles.",
    ];

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "safety"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "safety")),
          const SizedBox(height: 12),
          ...tips.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.health_and_safety, color: AppColors.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(t, style: const TextStyle(fontWeight: FontWeight.w600, height: 1.4)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
