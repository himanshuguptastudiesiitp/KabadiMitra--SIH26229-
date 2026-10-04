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

    final String? currentLotId = lot?.id;
    final String? selectedRecyclerId = lot?.recyclerId;
    final MaterialId? currentCategory = lot?.category;
    final double? currentWeight = lot?.weightKg;
    final double? currentValue = lot?.estimatedValue;

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "recyclers"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "recyclers")),
          if (currentCategory != null && currentWeight != null && currentValue != null) ...[
            const SizedBox(height: 8),
            Text(
              "${I18n.materialLabel(lang, currentCategory)} · $currentWeight ${I18n.t(lang, "kgUnit")} · ${inr(currentValue)}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 12),
          ...recyclers.map((r) {
            final selected = selectedRecyclerId == r.id;
            final int price = (currentWeight != null && currentCategory != null)
                ? (currentWeight * (rateFor(currentCategory).ratePerKg + r.rateBonus)).round()
                : 0;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(
                selected: selected,
                onTap: currentLotId == null
                    ? null
                    : () {
                        final String? id = currentLotId;
                        if (id == null) return;
                        store.offerLot(id, r.id, price.toDouble());
                      },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            r.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: ThemeX.ink(context),
                            ),
                          ),
                        ),
                        if (r.authorized)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.success.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              I18n.t(lang, "authorized"),
                              style: const TextStyle(
                                color: AppColors.success,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      kmLabel(r.km, I18n.t(lang, "kmUnit")),
                      style: TextStyle(color: ThemeX.muted(context)),
                    ),
                    if (currentLotId != null)
                      Text(
                        inr(price),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: selected
                              ? (ThemeX.isDark(context) ? AppColors.primaryLight : AppColors.primary)
                              : AppColors.primary,
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
          if (currentLotId != null && selectedRecyclerId != null) ...[
            const SizedBox(height: 12),
            BigButton(
              label: I18n.t(lang, "handover"),
              onPressed: () {
                final String id = currentLotId;
                store.acceptOffer(id);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HandoverScreen(lotId: id)),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
