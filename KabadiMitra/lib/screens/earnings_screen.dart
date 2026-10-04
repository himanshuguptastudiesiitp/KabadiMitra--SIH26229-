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
    final paid = store.lots.where((l) => l.paymentStatus == PaymentStatus.paid).toList();
    final pending = store.lots.where((l) => l.paymentStatus == PaymentStatus.pending).toList();
    final paidSum = paid.fold(0.0, (s, l) => s + l.amount);
    final pendingSum = pending.fold(0.0, (s, l) => s + l.amount);

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "earnings"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "earnings")),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  color: AppColors.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(I18n.t(lang, "paidDone"), style: const TextStyle(color: Colors.white70)),
                      Text(inr(paidSum),
                          style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(I18n.t(lang, "pendingPay"), style: Theme.of(context).textTheme.bodyMedium),
                      Text(inr(pendingSum),
                          style: const TextStyle(
                              color: AppColors.warning, fontSize: 26, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(I18n.t(lang, "history"), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...[...paid, ...pending].map((lot) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(I18n.materialLabel(lang, lot.category),
                              style: const TextStyle(fontWeight: FontWeight.w700)),
                          Text(
                            "${shortDate(lot.createdAt)} · ${lot.paymentMethod == PayMethod.cash ? I18n.t(lang, "cash") : I18n.t(lang, "upi")}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(inr(lot.amount),
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
                          Text(
                            lot.paymentStatus == PaymentStatus.paid
                                ? I18n.t(lang, "paidDone")
                                : I18n.t(lang, "pendingPay"),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: lot.paymentStatus == PaymentStatus.paid
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                          ),
                        ],
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
