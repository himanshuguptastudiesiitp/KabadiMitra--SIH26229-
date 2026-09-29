import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'recyclers_screen.dart';

class EstimateScreen extends StatelessWidget {
  final String lotId;
  const EstimateScreen({super.key, required this.lotId});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;
    if (store.lots.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(I18n.t(lang, "estimate"))),
        body: Center(child: Text(I18n.t(lang, "noLots"))),
      );
    }
    final lot = store.lots.firstWhere(
      (l) => l.id == lotId,
      orElse: () => store.lots.first,
    );
    final street = (lot.weightKg * (lot.ratePerKg - 12)).round();

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "estimate"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "estimate"), sub: lot.id),
          const SizedBox(height: 12),
          AppCard(
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  I18n.materialLabel(lang, lot.category),
                  style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                ),
                Text(
                  inr(lot.estimatedValue),
                  style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800),
                ),
                Text(
                  "${lot.weightKg} kg · ${inr(lot.ratePerKg)}${I18n.t(lang, "perKg")}",
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Street rate", style: Theme.of(context).textTheme.bodyMedium),
                Text(inr(street), style: Theme.of(context).textTheme.headlineMedium),
                Text(
                  "Better by ${inr(lot.estimatedValue - street)}",
                  style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BigButton(
            label: I18n.t(lang, "matchRecycler"),
            icon: Icons.store,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RecyclersScreen(lotId: lot.id)),
            ),
          ),
        ],
      ),
    );
  }
}
