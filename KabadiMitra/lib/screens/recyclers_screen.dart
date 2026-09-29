import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../services/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'handover_screen.dart';

class RecyclersScreen extends StatelessWidget {
  final String? lotId;
  const RecyclersScreen({super.key, this.lotId});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;
    Lot? lot;
    if (lotId != null) {
      try {
        lot = store.lots.firstWhere((l) => l.id == lotId);
      } catch (_) {
        lot = store.activeLot;
      }
    } else {
      lot = store.activeLot;
    }

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "recyclers"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "recyclers")),
          if (lot != null) ...[
            const SizedBox(height: 8),
            Text(
              "${I18n.materialLabel(lang, lot.category)} · ${lot.weightKg} kg · ${inr(lot.estimatedValue)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 12),
          ...recyclers.map((r) {
            final selected = lot?.recyclerId == r.id;
            final price = lot != null
                ? (lot.weightKg * (rateFor(lot.category).ratePerKg + r.rateBonus)).round()
                : 0;
            final currentLot = lot;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                onTap: currentLot == null
                    ? null
                    : () {
                        store.offerLot(currentLot.id, r.id, price.toDouble());
                      },
                child: Container(
                  decoration: selected
                      ? BoxDecoration(
                          border: Border.all(color: AppColors.primary, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        )
                      : null,
                  padding: selected ? const EdgeInsets.all(4) : EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            r.name,
                            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                          ),
                          if (r.authorized)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "Authorized",
                                style: TextStyle(
                                  color: AppColors.success,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(kmLabel(r.km), style: Theme.of(context).textTheme.bodyMedium),
                      if (currentLot != null)
                        Text(
                          inr(price),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                            color: AppColors.primary,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          if (lot != null && lot.recyclerId != null) ...[
            const SizedBox(height: 12),
            BigButton(
              label: I18n.t(lang, "handover"),
              onPressed: () {
                final current = lot!;
                store.acceptOffer(current.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HandoverScreen(lotId: current.id)),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
