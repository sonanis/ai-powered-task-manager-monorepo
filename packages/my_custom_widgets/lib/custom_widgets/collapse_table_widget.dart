import 'package:flutter/material.dart';

class CollapseTableWidget extends StatefulWidget {
  final List<RowItem> items; // 每行Item的Widget列表
  final bool isCollapsible; // 是否启用折叠功能
  final int maxVisibleItems; // 折叠时显示的最大行数，默认3
  final Duration animationDuration; // 动画持续时间，默认300ms

  const CollapseTableWidget({
    super.key,
    required this.items,
    this.isCollapsible = false,
    this.maxVisibleItems = 3,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<CollapseTableWidget> createState() => _CollapseTableWidgetState();
}

class _CollapseTableWidgetState extends State<CollapseTableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleCollapse() {
    if (!widget.isCollapsible) return;
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // 宽度填满父组件
      child: Stack(
        children: [
          // Content Widget
          AnimatedSize(
            duration: widget.animationDuration,
            curve: Curves.easeInOut,
            child: ClipRect(
              child: Column(
                mainAxisSize: MainAxisSize.min, // 高度自适应
                children: [
                  for (int i = 0; i < widget.items.length; i++)
                    if (!_isExpanded && i >= widget.maxVisibleItems) ...[
                      const SizedBox.shrink(), // 折叠时隐藏多余项
                    ] else
                      ItemRow(item: widget.items[i]),
                ],
              ),
            ),
          ),
          // Arrow Widget，覆盖在Content Widget上，底部对齐
          if (widget.isCollapsible)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0, // 底部对齐
              child: GestureDetector(
                onTap: _toggleCollapse,
                child: Container(
                  // height: 40,
                  color: Colors.red.withValues(alpha: 0.5),
                  alignment: Alignment.center,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value * 3.14159, // 旋转180度
                        child: const Icon(Icons.arrow_drop_down, size: 24),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ItemRow extends StatelessWidget {
  final RowItem item;

  const ItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: item.alignment, // 根据RowItem的alignment对齐
      children: [
        // Label 部分，默认占30%，支持自定义宽度和内容
        Expanded(
          flex: 3,
          child: item.label,
        ),
        // 内容部分，占剩余70%，支持自适应高度
        Expanded(
          flex: 7,
          child: item.content,
        ),
      ],
    );
  }
}

// 自定义 RowItem 类，支持 Label 和 Content 的灵活配置
class RowItem {
  final Widget label; // Label 部分，支持文本、Icon 或自定义
  final Widget content; // 内容部分，支持文本、图片、视频等
  final CrossAxisAlignment alignment; // 控制 Label 和 Content 的对齐方式

  const RowItem({
    required this.label,
    required this.content,
    this.alignment = CrossAxisAlignment.center, // 默认水平居中
  });

  // 便捷构造函数，允许传入字符串作为 Label
  RowItem.text({
    required String labelText, // 简单的文本参数
    required this.content,
    this.alignment = CrossAxisAlignment.center, // 默认水平居中
    TextStyle? labelStyle, // 可选的文本样式
  }) : label = Text(
          labelText,
          style: labelStyle,
        );
}

