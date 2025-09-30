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
                              DropdownButton<String>(
                                value: filterValues['status'],
                                hint: const Text("选择状态"),
                                items: ['Active', 'Inactive', null]
                                    .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value ?? "无"),
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
                                title: const Text('选项 0'),
                                value: filterValues['option0'] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    filterValues['option0'] = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        filterValues = Map.from(initialValues ?? {});
                                      });
                                    },
                                    child: const Text("重置"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => onConfirm(filterValues),
                                    child: const Text("确认"),
                                  ),
                                ],
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
          Expanded(child: Container(
            color: Colors.orangeAccent.withValues(alpha: 0.3),
          ))
        ],
      ),
    );
  }
}
