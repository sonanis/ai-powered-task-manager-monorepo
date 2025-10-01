import 'package:flutter/material.dart';
import 'package:my_custom_widgets/my_custom_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final demoItems = List<RowItem>.generate(
      8,
      (i) => RowItem(
        label: Text('标签 $i / Label $i'),
        content: Text('内容内容内容 $i / Content $i'),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: const Text('Collapse Table Demo')),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: CollapseTableWidget(
    //       isCollapsible: true,
    //       items: [
    //         RowItem(
    //           label: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: const [
    //               Icon(Icons.star, color: Colors.red),
    //               Text("Name"),
    //             ],
    //           ),
    //           content: const Text("Text Content"),
    //         ),
    //         RowItem(
    //           label: const Icon(Icons.person),
    //           content: Image.network(
    //             "https://via.placeholder.com/150",
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         RowItem.text(
    //           labelText: 'Age',
    //           content: const Text("25"),
    //           alignment: CrossAxisAlignment.start, // Top 对齐
    //         ),
    //         RowItem(
    //           label: const Text("Address"),
    //           content: const Text("123 Street"),
    //         ),
    //         RowItem(
    //           label: const Text("Hobby"),
    //           content: const Text("Gaming"),
    //         ),
    //       ],
    //       maxVisibleItems: 3,
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(title: const Text('Popup Filter Demo')),
      body: Column(
        children: [
          // 简单内容测试 - 演示自适应高度
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.blue.withValues(alpha: 0.3),
                  padding: const EdgeInsets.all(16.0),
                  child: PopupFilterWidget(
                    anchor: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.filter_alt, size: 30),
                        Text('简单筛选', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    onFilterConfirm: (filters) => print('Simple filter: $filters'),
                    filterItemsBuilder: (context, initialValues, onConfirm) {
                      return [
                        StatefulBuilder(
                          builder: (context, setState) {
                            Map<String, dynamic> filterValues = Map.from(initialValues ?? {});
                            
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('这是一个简单的筛选示例', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 16),
                                DropdownButton<String>(
                                  value: filterValues['category'],
                                  hint: const Text("选择分类"),
                                  items: ['工作', '生活', '学习']
                                      .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterValues['category'] = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                CheckboxListTile(
                                  title: const Text('包含已完成'),
                                  value: filterValues['includeCompleted'] ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      filterValues['includeCompleted'] = value;
                                    });
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ];
                    },
                  ),
                ),
                Container(
                  color: Colors.orange.withValues(alpha: 0.3),
                  padding: const EdgeInsets.all(16.0),
                  child: PopupFilterWidget(
                    anchor: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.filter_list, size: 30),
                        Text('复杂筛选', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    onFilterConfirm: (filters) => print('Complex filter: $filters'),
                    filterItemsBuilder: (context, initialValues, onConfirm) {
                      return [
                        StatefulBuilder(
                          builder: (context, setState) {
                            Map<String, dynamic> filterValues = Map.from(initialValues ?? {});
                            
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('这是一个复杂的筛选示例', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 16),
                                // 这里包含之前的所有复杂筛选内容
                                DropdownButton<String>(
                                  value: filterValues['status'],
                                  hint: const Text("选择状态"),
                                  items: ['Active', 'Inactive', 'Pending', 'Completed', 'Cancelled']
                                      .map((value) => DropdownMenuItem(
                                          value: value,
                                          child: Text(value),
                                        ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      filterValues['status'] = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                CheckboxListTile(
                                  title: const Text('包含已完成任务'),
                                  value: filterValues['includeCompleted'] ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      filterValues['includeCompleted'] = value;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('仅显示我的任务'),
                                  value: filterValues['myTasksOnly'] ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      filterValues['myTasksOnly'] = value;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('显示过期任务'),
                                  value: filterValues['showOverdue'] ?? false,
                                  onChanged: (value) {
                                    setState(() {
                                      filterValues['showOverdue'] = value;
                                    });
                                  },
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('标签', style: TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 8,
                                        children: ['工作', '个人', '紧急', '学习']
                                            .map((tag) => FilterChip(
                                                  label: Text(tag),
                                                  selected: (filterValues['tags'] as List<String>?)?.contains(tag) ?? false,
                                                  onSelected: (selected) {
                                                    setState(() {
                                                      List<String> tags = List<String>.from(filterValues['tags'] ?? []);
                                                      if (selected) {
                                                        tags.add(tag);
                                                      } else {
                                                        tags.remove(tag);
                                                      }
                                                      filterValues['tags'] = tags;
                                                    });
                                                  },
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Container()),
              Container(
                color: Colors.green,
                padding: const EdgeInsets.all(16.0),
                child: PopupFilterWidget(
                  anchor: const Icon(Icons.filter_list, size: 40),
                  onSearch: (query) => print('Search query: $query'),
                  onFilterConfirm: (filters) => print('Filter values: $filters'),
                  initialFilterValues: {'status': 'Active', 'option0': false},
                  filterItemsBuilder: (context, initialValues, onConfirm) {
                    return [
                      StatefulBuilder(
                        builder: (context, setState) {
                          Map<String, dynamic> filterValues = Map.from(initialValues ?? {});
              
                          return Column(
                            children: [
                              // 状态下拉框
                              DropdownButton<String>(
                                value: filterValues['status'],
                                hint: const Text("选择状态"),
                                items: ['Active', 'Inactive', 'Pending', 'Completed', 'Cancelled']
                                    .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['status'] = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              
                              // 优先级下拉框
                              DropdownButton<String>(
                                value: filterValues['priority'],
                                hint: const Text("选择优先级"),
                                items: ['高', '中', '低', '紧急']
                                    .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['priority'] = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              
                              // 多个复选框选项
                              CheckboxListTile(
                                title: const Text('包含已完成任务'),
                                value: filterValues['includeCompleted'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['includeCompleted'] = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: const Text('仅显示我的任务'),
                                value: filterValues['myTasksOnly'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['myTasksOnly'] = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: const Text('显示过期任务'),
                                value: filterValues['showOverdue'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['showOverdue'] = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: const Text('包含子任务'),
                                value: filterValues['includeSubtasks'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['includeSubtasks'] = value;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: const Text('显示归档项目'),
                                value: filterValues['showArchived'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['showArchived'] = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              
                              // 日期范围选择器
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('日期范围', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              // 这里可以添加日期选择器
                                              setState(() {
                                                filterValues['startDate'] = '2024-01-01';
                                              });
                                            },
                                            child: Text(filterValues['startDate'] ?? '开始日期'),
                                          ),
                                        ),
                                        const Text(' - '),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              setState(() {
                                                filterValues['endDate'] = '2024-12-31';
                                              });
                                            },
                                            child: Text(filterValues['endDate'] ?? '结束日期'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // 标签选择
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('标签', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      children: ['工作', '个人', '紧急', '学习', '健康', '购物', '旅行']
                                          .map((tag) => FilterChip(
                                                label: Text(tag),
                                                selected: (filterValues['tags'] as List<String>?)?.contains(tag) ?? false,
                                                onSelected: (selected) {
                                                  setState(() {
                                                    List<String> tags = List<String>.from(filterValues['tags'] ?? []);
                                                    if (selected) {
                                                      tags.add(tag);
                                                    } else {
                                                      tags.remove(tag);
                                                    }
                                                    filterValues['tags'] = tags;
                                                  });
                                                },
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // 滑块控件
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('完成度: ${((filterValues['completion'] ?? 0.0) * 100).toInt()}%'),
                                    Slider(
                                      value: filterValues['completion'] ?? 0.0,
                                      onChanged: (value) {
                                        setState(() {
                                          filterValues['completion'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(child: Container()),
              Container(
                color: Colors.green,
                padding: const EdgeInsets.all(16.0),
                child: PopupFilterWidget(
                  anchor: const Icon(Icons.filter_list, size: 40),
                  onSearch: (query) => print('Search query: $query'),
                  onFilterConfirm: (filters) => print('Filter values: $filters'),
                  initialFilterValues: {'status': 'Active', 'option0': false},
                  filterItemsBuilder: (context, initialValues, onConfirm) {
                    return [
                      StatefulBuilder(
                        builder: (context, setState) {
                          Map<String, dynamic> filterValues = Map.from(initialValues ?? {});
              
                          return Column(
                            children: [    
                              // 标签选择
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('标签', style: TextStyle(fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      children: ['工作', '个人', '紧急', '学习', '健康', '购物', '旅行']
                                          .map((tag) => FilterChip(
                                                label: Text(tag),
                                                selected: (filterValues['tags'] as List<String>?)?.contains(tag) ?? false,
                                                onSelected: (selected) {
                                                  setState(() {
                                                    List<String> tags = List<String>.from(filterValues['tags'] ?? []);
                                                    if (selected) {
                                                      tags.add(tag);
                                                    } else {
                                                      tags.remove(tag);
                                                    }
                                                    filterValues['tags'] = tags;
                                                  });
                                                },
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              
                              // 滑块控件
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('完成度: ${((filterValues['completion'] ?? 0.0) * 100).toInt()}%'),
                                    Slider(
                                      value: filterValues['completion'] ?? 0.0,
                                      onChanged: (value) {
                                        setState(() {
                                          filterValues['completion'] = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                    ];
                  },
                ),
              ),
            ],
          ),
          
          Expanded(child: Container(
            color: Colors.orangeAccent.withValues(alpha: 0.3),
          ))
        ],
      ),
    );
  }
}
