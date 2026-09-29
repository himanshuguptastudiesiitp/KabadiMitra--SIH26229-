import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/types.dart';
import '../services/app_store.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../utils/i18n.dart';
import '../widgets/ui_bits.dart';
import 'add_screen.dart';
import 'camera_screen.dart';
import 'earnings_screen.dart';
import 'prices_screen.dart';
import 'recyclers_screen.dart';
import 'safety_screen.dart';
import 'user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<AppStore>();
    final lang = store.language;
    final earned = store.todayEarned();
    final recent = store.lots.take(5).toList();

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          children: [
            Text(
              "${I18n.t(lang, "ramRam")}, ${store.displayName}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(I18n.t(lang, "appName"), style: Theme.of(context).textTheme.headlineLarge),
            Text(I18n.t(lang, "chainSub"), style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            PipelineStrip(
              current: store.activeLot != null
                  ? LotStatusLike.valued
                  : LotStatusLike.collected,
            ),
            const SizedBox(height: 12),
            AppCard(
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    I18n.t(lang, "todayEarned"),
                    style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    inr(earned),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            BigButton(
              label: I18n.t(lang, "openCamera"),
              icon: Icons.camera_alt,
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CameraScreen()),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.4,
              children: [
                _Quick(Icons.add_a_photo, I18n.t(lang, "addScrap"), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddScreen()));
                }),
                _Quick(Icons.sell, I18n.t(lang, "priceBoard"), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PricesScreen()));
                }),
                _Quick(Icons.account_balance_wallet, I18n.t(lang, "earnings"), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const EarningsScreen()));
                }),
                _Quick(Icons.store, I18n.t(lang, "recyclers"), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const RecyclersScreen()));
                }),
                _Quick(Icons.health_and_safety, I18n.t(lang, "safety"), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SafetyScreen()));
                }),
                _Quick(Icons.person, I18n.t(lang, "userPage"), () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const UserScreen()));
                }),
              ],
            ),
            const SizedBox(height: 20),
            Text(I18n.t(lang, "recentLots"), style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            if (recent.isEmpty)
              Text(I18n.t(lang, "noLots"), style: Theme.of(context).textTheme.bodyMedium)
            else
              ...recent.map(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              inr(lot.amount),
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                            ),
                            Text(
                              lot.paymentStatus == PaymentStatus.paid
                                  ? I18n.t(lang, "paidDone")
                                  : (lot.status == LotStatus.offered
                                      ? I18n.t(lang, "pendingPay")
                                      : lot.status.name),
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
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Quick extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _Quick(this.icon, this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, size: 28, color: AppColors.primary),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
