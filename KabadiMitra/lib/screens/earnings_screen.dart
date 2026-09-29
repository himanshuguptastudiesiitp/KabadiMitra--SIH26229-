import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;
    final paidLots = store.lots.where((l) => l.paymentStatus == PaymentStatus.paid).toList();
    final total = paidLots.fold(0.0, (s, l) => s + l.amount);

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "earnings"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "earnings")),
          const SizedBox(height: 12),
          AppCard(
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  I18n.t(lang, "earnings"),
                  style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                ),
                Text(
                  inr(total),
                  style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(I18n.t(lang, "history"), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (paidLots.isEmpty)
            Text(I18n.t(lang, "noLots"), style: Theme.of(context).textTheme.bodyMedium)
          else
            ...paidLots.map(
              (lot) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              I18n.materialLabel(lang, lot.category),
                              style: const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${lot.weightKg} kg · ${shortDate(lot.createdAt)}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        inr(lot.amount),
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
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
