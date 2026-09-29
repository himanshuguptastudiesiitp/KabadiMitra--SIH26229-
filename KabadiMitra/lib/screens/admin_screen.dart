import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_store.dart';
import '../services/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;

    final byMaterial = <String, double>{};
    for (final lot in store.lots) {
      final key = lot.category.name;
      byMaterial[key] = (byMaterial[key] ?? 0) + lot.weightKg;
    }

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "adminDesk"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "adminDesk")),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      Text(
                        "${store.lots.length}",
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                      ),
                      Text(I18n.t(lang, "lots"), style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      Text(
                        "${recyclers.length}",
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                      ),
                      Text(I18n.t(lang, "recyclers"), style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text("Material flow", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (byMaterial.isEmpty)
            Text(I18n.t(lang, "noLots"), style: Theme.of(context).textTheme.bodyMedium)
          else
            ...byMaterial.entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.key.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w700)),
                      Text(
                        "${e.value.toStringAsFixed(1)} kg",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          Text(I18n.t(lang, "recentLots"), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...store.lots.take(10).map(
            (lot) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AppCard(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lot.id, style: const TextStyle(fontWeight: FontWeight.w700)),
                          Text(
                            "${I18n.materialLabel(lang, lot.category)} · ${lot.weightKg} kg",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Text(inr(lot.amount), style: const TextStyle(fontWeight: FontWeight.w800)),
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
