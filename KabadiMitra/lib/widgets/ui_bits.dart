import 'package:flutter/material.dart';
import '../models/types.dart';
import '../theme/app_theme.dart';
import '../utils/i18n.dart';

/// Theme-aware colors so light + dark both stay readable.
class ThemeX {
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color surface(BuildContext context) =>
      isDark(context) ? AppColors.darkSurface : AppColors.surface;

  static Color surfaceAlt(BuildContext context) =>
      isDark(context) ? AppColors.darkSurfaceAlt : AppColors.surfaceAlt;

  static Color ink(BuildContext context) =>
      isDark(context) ? AppColors.darkInk : AppColors.ink;

  static Color muted(BuildContext context) =>
      isDark(context) ? AppColors.darkMuted : AppColors.muted;

  static Color line(BuildContext context) =>
      isDark(context) ? AppColors.darkLine : AppColors.line;
}

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
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final bool selected;

  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = color ?? ThemeX.surface(context);
    final borderColor = selected ? AppColors.primary : ThemeX.line(context);
    final card = Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: selected
            ? (ThemeX.isDark(context)
                ? AppColors.primary.withValues(alpha: 0.22)
                : AppColors.primary.withValues(alpha: 0.08))
            : bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: selected ? 2 : 1),
      ),
      child: child,
    );
    if (onTap != null) {
      return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12), child: card);
    }
    return card;
  }
}

/// Chip / pill used for material type, payment method, language, role, etc.
/// Always readable in light and dark (selected + unselected).
class SelectChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final bool expanded;

  const SelectChip({
    super.key,
    required this.label,
    required this.selected,
    this.onTap,
    this.expanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? AppColors.primary
        : ThemeX.surfaceAlt(context);
    final fg = selected ? Colors.white : ThemeX.ink(context);
    final border = selected ? AppColors.primary : ThemeX.line(context);

    final child = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: border, width: selected ? 2 : 1),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: fg,
        ),
      ),
    );

    final tappable = GestureDetector(onTap: onTap, child: child);
    if (expanded) return Expanded(child: tappable);
    return tappable;
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
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
        Text(label),
      ],
    );
    if (primary) {
      return ElevatedButton(onPressed: onPressed, child: child);
    }
    return OutlinedButton(onPressed: onPressed, child: child);
  }
}

class PipelineStrip extends StatelessWidget {
  final LotStatusLike current;
  final Lang lang;
  const PipelineStrip({super.key, required this.current, required this.lang});

  static const _keys = ["pipeCollect", "pipeIdentify", "pipeValue", "pipeMatch", "pipeHandover"];

  int get _idx {
    switch (current) {
      case LotStatusLike.collected:
        return 0;
      case LotStatusLike.identified:
        return 1;
      case LotStatusLike.valued:
      case LotStatusLike.offered:
        return 2;
      case LotStatusLike.accepted:
        return 3;
      default:
        return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final idx = _idx;
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_keys.length, (i) {
          final active = i <= idx;
          return Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: active ? AppColors.primary : ThemeX.surfaceAlt(context),
                  child: Text(
                    "${i + 1}",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: active ? Colors.white : ThemeX.muted(context),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  I18n.t(lang, _keys[i]),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: active ? AppColors.primary : ThemeX.muted(context),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

enum LotStatusLike { collected, identified, valued, offered, accepted, handover, paid }
