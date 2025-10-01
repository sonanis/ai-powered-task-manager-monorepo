import 'package:flutter/material.dart';

/// 筛选内容组件 / Filter Content Widget
/// 
/// 提供一个标准的筛选布局，包含：
/// - 上部分：自定义筛选组件区域
/// - 下部分：重置和确认按钮
/// 
/// Provides a standard filter layout including:
/// - Top section: Custom filter widgets area
/// - Bottom section: Reset and confirm buttons
class FilterContentWidget extends StatelessWidget {
  /// 筛选组件构建器 / Filter widgets builder
  final Widget Function(BuildContext context) contentBuilder;
  
  /// 重置按钮回调 / Reset button callback
  final VoidCallback? onReset;
  
  /// 确认按钮回调 / Confirm button callback
  final VoidCallback? onConfirm;
  
  /// 重置按钮文本 / Reset button text
  final String resetText;
  
  /// 确认按钮文本 / Confirm button text
  final String confirmText;
  
  /// 按钮区域的内边距 / Button area padding
  final EdgeInsets buttonPadding;
  
  /// 内容区域的内边距 / Content area padding
  final EdgeInsets contentPadding;
  
  /// 按钮之间的间距 / Space between buttons
  final double buttonSpacing;

  const FilterContentWidget({
    super.key,
    required this.contentBuilder,
    this.onReset,
    this.onConfirm,
    this.resetText = '重置',
    this.confirmText = '确认',
    this.buttonPadding = const EdgeInsets.all(16.0),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.buttonSpacing = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 上部分：筛选内容区域 / Top section: Filter content area
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: constraints.maxHeight - 120, // 为按钮区域预留空间
                ),
                child: SingleChildScrollView(
                  padding: contentPadding,
                  child: contentBuilder(context),
                ),
              ),
            ),
            
            // 下部分：按钮区域 / Bottom section: Button area
            Container(
              width: double.infinity,
              padding: buttonPadding,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 0.5,
                  ),
                ),
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    // 重置按钮 / Reset button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onReset,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(resetText),
                      ),
                    ),
                    
                    SizedBox(width: buttonSpacing),
                    
                    // 确认按钮 / Confirm button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onConfirm,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(confirmText),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}