import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  static const tips = [
    (Icons.local_fire_department, "tipBurn", "tipBurnB"),
    (Icons.battery_charging_full, "tipBat", "tipBatB"),
    (Icons.tv, "tipCrt", "tipCrtB"),
    (Icons.memory, "tipPcb", "tipPcbB"),
  ];

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<AppStore>().language;
    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "safety"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "safety"), sub: I18n.t(lang, "staySafe")),
          const SizedBox(height: 12),
          ...tips.map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(tip.$1, color: AppColors.warning),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(I18n.t(lang, tip.$2), style: const TextStyle(fontWeight: FontWeight.w800)),
                            const SizedBox(height: 4),
                            Text(I18n.t(lang, tip.$3), style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
