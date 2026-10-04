import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../services/mock_data.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';

class HandoverScreen extends StatefulWidget {
  final String lotId;
  const HandoverScreen({super.key, required this.lotId});

  @override
  State<HandoverScreen> createState() => _HandoverScreenState();
}

class _HandoverScreenState extends State<HandoverScreen> {
  PayMethod method = PayMethod.cash;

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;
    if (store.lots.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(I18n.t(lang, "handover"))),
        body: Center(child: Text(I18n.t(lang, "noLots"))),
      );
    }
    final lot = store.lots.firstWhere(
      (l) => l.id == widget.lotId,
      orElse: () => store.lots.first,
    );
    Recycler? rec;
    try {
      rec = recyclers.firstWhere((r) => r.id == lot.recyclerId);
    } catch (_) {
      rec = null;
    }

    return Scaffold(
      appBar: AppBar(title: Text(I18n.t(lang, "handover"))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ScreenTitle(title: I18n.t(lang, "handover"), sub: lot.id),
          const SizedBox(height: 12),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(I18n.materialLabel(lang, lot.category),
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: ThemeX.ink(context),
                    )),
                Text("${lot.weightKg} ${I18n.t(lang, "kgUnit")} · ${rec?.name ?? ""}",
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 8),
                Text(inr(lot.amount),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: ThemeX.ink(context),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(I18n.t(lang, "payHow"), style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Row(
            children: [
              SelectChip(
                label: I18n.t(lang, "cash"),
                selected: method == PayMethod.cash,
                expanded: true,
                onTap: () => setState(() => method = PayMethod.cash),
              ),
              const SizedBox(width: 10),
              SelectChip(
                label: I18n.t(lang, "upi"),
                selected: method == PayMethod.upi,
                expanded: true,
                onTap: () => setState(() => method = PayMethod.upi),
              ),
            ],
          ),
          const SizedBox(height: 24),
          BigButton(
            label: I18n.t(lang, "confirmHandover"),
            onPressed: () {
              store.handoverLot(lot.id, method);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${I18n.t(lang, "paidDone")} ${inr(lot.amount)}")),
              );
              Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
            },
          ),
        ],
      ),
    );
  }
}
