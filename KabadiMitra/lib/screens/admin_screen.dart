import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
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
    final kg = store.lots.fold(0.0, (s, l) => s + l.weightKg);
    final cash = store.lots
        .where((l) => l.paymentStatus == PaymentStatus.paid)
        .fold(0.0, (s, l) => s + l.amount);

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "adminDesk"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "adminDesk")),
          const SizedBox(height: 12),
          PipelineStrip(lang: lang, current: LotStatusLike.paid),
          const SizedBox(height: 12),
          Row(
            children: [
              _Stat(I18n.t(lang, "lots"), "${store.lots.length}"),
              const SizedBox(width: 8),
              _Stat(I18n.t(lang, "kgUnit"), kg.toStringAsFixed(0)),
              const SizedBox(width: 8),
              _Stat(I18n.t(lang, "paidDone"), inr(cash)),
            ],
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.t(lang, "materialFlow"), style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                ...priceBoard.map((row) {
                  final n = store.lots
                      .where((l) => l.category == row.category)
                      .fold(0.0, (s, l) => s + l.weightKg);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(I18n.materialLabel(lang, row.category)),
                        Text("${n.toStringAsFixed(1)} ${I18n.t(lang, "kgUnit")}",
                            style: const TextStyle(fontWeight: FontWeight.w700)),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppCard(
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
