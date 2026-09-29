import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum LotStatusLike { collected, identified, valued, matched, handover }

class ScreenTitle extends StatelessWidget {
  final String title;
  final String? sub;
  const ScreenTitle({super.key, required this.title, this.sub});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        if (sub != null) ...[
          const SizedBox(height: 4),
          Text(sub!, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ],
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final VoidCallback? onTap;
  const AppCard({super.key, required this.child, this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = color ?? Theme.of(context).cardTheme.color ?? AppColors.surface;
    final content = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: color == null
            ? Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.2))
            : null,
      ),
      child: child,
    );
    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: content,
    );
  }
}

class BigButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool primary;
  final IconData? icon;
  const BigButton({
    super.key,
    required this.label,
    this.onPressed,
    this.primary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (primary) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
          label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
          ),
        ),
      );
    }
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
        label: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class PipelineStrip extends StatelessWidget {
  final LotStatusLike current;
  const PipelineStrip({super.key, required this.current});

  static const steps = ["COLLECT", "IDENTIFY", "VALUE", "MATCH", "HANDOVER"];

  int get _index {
    switch (current) {
      case LotStatusLike.collected:
        return 0;
      case LotStatusLike.identified:
        return 1;
      case LotStatusLike.valued:
        return 2;
      case LotStatusLike.matched:
        return 3;
      case LotStatusLike.handover:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final idx = _index;
    return Row(
      children: List.generate(steps.length, (i) {
        final on = i <= idx;
        return Expanded(
          child: Column(
            children: [
              Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: on ? AppColors.primary : AppColors.muted.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                steps[i],
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: on ? AppColors.primary : AppColors.muted,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
