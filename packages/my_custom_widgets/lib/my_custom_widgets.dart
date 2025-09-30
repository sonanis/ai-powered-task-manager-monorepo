import 'package:flutter/material.dart';
export 'custom_widgets/collapse_table_widget.dart';
export 'custom_widgets/popup_filter_widget.dart';

/// M3 按钮示例 / Material 3 Elevated Action Button
class M3ActionButton extends StatelessWidget {
  /// 文本标签 / Text label
  final String label;

  /// 点击回调 / Tap callback
  final VoidCallback? onPressed;

  /// 图标（可选）/ Optional leading icon
  final IconData? leadingIcon;

  /// 是否充满宽度 / Expand to max width
  final bool expanded;

  const M3ActionButton({
    super.key,
    required this.label,
    this.onPressed,
    this.leadingIcon,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton.icon(
      onPressed: onPressed,
      icon: leadingIcon != null ? Icon(leadingIcon) : const SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );

    if (!expanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

/// M3 卡片标题 / Material 3 Card Header
class M3CardHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const M3CardHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
