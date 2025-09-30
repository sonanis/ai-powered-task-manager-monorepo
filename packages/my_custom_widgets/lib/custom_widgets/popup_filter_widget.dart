import 'package:flutter/material.dart';

typedef FilterItemsBuilder = List<Widget> Function(BuildContext context, Map<String, dynamic>? initialFilterValues, void Function(Map<String, dynamic>) onFilterConfirm);

class PopupFilterWidget extends StatefulWidget {
  final Widget anchor; // 触发弹出的Anchor Widget
  final Function(String)? onSearch; // 搜索回调，参数为关键词
  final Function(Map<String, dynamic>)? onFilterConfirm; // 筛选确认回调，返回筛选项值
  final Map<String, dynamic>? initialFilterValues; // 初始筛选项值
  final FilterItemsBuilder filterItemsBuilder;

  const PopupFilterWidget({
    super.key,
    required this.anchor,
    required this.filterItemsBuilder,
    this.onSearch,
    this.onFilterConfirm,
    this.initialFilterValues,
  });

  @override
  State<PopupFilterWidget> createState() => _PopupFilterWidgetState();
}

class _PopupFilterWidgetState extends State<PopupFilterWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _anchorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!mounted) return;
      setState(() {}); // 切换 Tab 时重建以自适应内容高度
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    if (widget.onSearch != null) {
      widget.onSearch!(query);
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque, // 确保点击区域可检测
        onTap: () {
          debugPrint("onTap Anchor Widget !!!");
          final renderBox = _anchorKey.currentContext?.findRenderObject() as RenderBox?;
          final offset = renderBox?.localToGlobal(Offset.zero);
          
          // 获取屏幕顶部的安全区域（状态栏等）
          final mediaQuery = MediaQuery.of(context);
          final statusBarHeight = mediaQuery.padding.top;
          
          // 获取AppBar高度（如果存在）
          final appBarHeight = Scaffold.of(context).hasAppBar ? kToolbarHeight : 0.0;
          
          // 计算弹窗位置：与anchor顶部对齐，考虑AppBar
          final anchorTop = (offset?.dy ?? 0.0) - statusBarHeight - appBarHeight;
          
          debugPrint("Anchor position - global: ${offset?.dy}, statusBar: $statusBarHeight, appBar: $appBarHeight, adjusted: $anchorTop, size: ${renderBox?.size}");
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (dialogContext) => _buildPopup(dialogContext, anchorTop),
          );
        },
        child: Container(key: _anchorKey, child: widget.anchor), // 确保anchor有大小并可测量其位置
      );
  }

  Widget _buildPopup(BuildContext dialogContext, double anchorTop) {
    return GestureDetector(
      onTap: () => Navigator.of(dialogContext).pop(), // 点击空白关闭
      child: Container(
        width: MediaQuery.of(dialogContext).size.width,
        height: MediaQuery.of(dialogContext).size.height,
        color: Colors.transparent, // Popup Widget 完全透明
        child: Stack(
          children: [
            // 确保内容可见
            Positioned(
              top: anchorTop,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5), // 黑色半透明背景
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TabBar(
                                controller: _tabController,
                                tabs: const [
                                  Tab(text: "搜索"),
                                  Tab(text: "筛选"),
                                ],
                                indicatorColor: Colors.blue,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                onTap: (index) {
                                  // 确保弹窗内容在点击切换Tab时重建
                                  // 由于弹窗位于新的Route中，父State的setState不足以触发弹窗重建
                                  // 使用 AnimatedBuilder 监听 _tabController，因此这里只是保障即时响应
                                  if (mounted) {
                                    setState(() {});
                                  }
                                },
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                child: AnimatedBuilder(
                                  animation: _tabController,
                                  builder: (context, _) {
                                    return _buildTabContent(dialogContext);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
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

  Widget _buildTabContent(BuildContext dialogContext) {
    if (_tabController.index == 0) {
      // 搜索 Tab：内容高度随内部控件自适应
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: "输入关键词",
                border: OutlineInputBorder(),
              ),
              onSubmitted: _handleSearch,
            ),
          ],
        ),
      );
    } else {
      // 筛选 Tab：当内容较多时使用滚动容器，但整体高度仍按内容计算
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.filterItemsBuilder(
              dialogContext,
              widget.initialFilterValues,
              (values) {
                widget.onFilterConfirm?.call(values);
                Navigator.of(dialogContext).pop();
              },
            ),
          ),
        ),
      );
    }
  }
}

