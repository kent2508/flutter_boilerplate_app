import 'package:flutter/material.dart';
import 'package:vpb_flutter_boilerplate/scr/example_presentation/listview_example/components/action_button.dart';

import 'components/expandable_fab.dart';

class ListViewScene extends StatefulWidget {
  const ListViewScene({Key? key}) : super(key: key);
  static String routeName = '/listView';
  @override
  _ListViewSceneState createState() => _ListViewSceneState();
}

class _ListViewSceneState extends State<ListViewScene> {
  late ListViewType _type = ListViewType.Normal;
  late List<String> items;
  late int itemCount;
  double _wheelItemCount = 20.0;
  double _wheelOffAxisFractionValue = 0.0;
  Axis _infiniteAxis = Axis.vertical;
  Axis _normalAxis = Axis.vertical;
  final TextEditingController _itemCountTextController =
      TextEditingController();
  final TextEditingController _wheelItemCountTextController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _wheelScrollController = ScrollController();
  late double screenHeight;
  late double screenWidth;

  @override
  void initState() {
    super.initState();
    itemCount = 20;
    items = List<String>.generate(itemCount, (i) => 'Item $i');
  }

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments as String;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            args,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: _body(),
        floatingActionButton: ExpandableFab(distance: 112, childen: [
          ActionButon(
            onPressed: () {
              _changeListViewType(ListViewType.Normal);
            },
            icon: const Icon(
              Icons.list,
              color: Colors.white,
            ),
          ),
          ActionButon(
            onPressed: () => _changeListViewType(ListViewType.Infinity),
            icon: const Icon(
              Icons.settings_backup_restore,
              color: Colors.white,
            ),
          ),
          ActionButon(
            onPressed: () => _changeListViewType(ListViewType.Wheel),
            icon: const Icon(
              Icons.settings_backup_restore,
              color: Colors.white,
            ),
          ),
        ]),
      ),
    );
  }

  Widget _body() {
    switch (_type) {
      case ListViewType.Normal:
        return SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight / 2,
                  child: ListView.builder(
                    itemCount: items.length,
                    scrollDirection: _normalAxis,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Text('${items[index]}'),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    height: screenHeight / 2,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const Text(
                          'Listview',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Listview direction'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                const Text('Vertical'),
                                Radio(
                                    value: Axis.vertical,
                                    groupValue: _normalAxis,
                                    onChanged: (Axis? value) {
                                      setState(() {
                                        _normalAxis = value!;
                                      });
                                    })
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Horizontal'),
                                Radio(
                                    value: Axis.horizontal,
                                    groupValue: _normalAxis,
                                    onChanged: (Axis? value) {
                                      setState(() {
                                        _normalAxis = value!;
                                      });
                                    })
                              ],
                            ),
                          ],
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Listview item count'),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 32,
                              width: screenWidth / 3,
                              child: TextField(
                                controller: _itemCountTextController,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                final int count = int.parse(
                                    _itemCountTextController.text.trim());
                                if (count >= 0) {
                                  setState(() {
                                    itemCount = count;
                                    items = List<String>.generate(
                                        itemCount, (i) => 'Item $i');
                                    _scrollController.animateTo(0.0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                    FocusScope.of(context).unfocus();
                                    _itemCountTextController.clear();
                                  });
                                }
                              },
                              child: const Text('Apply'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case ListViewType.Infinity:
        return Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight / 2,
              child: ListView.builder(
                scrollDirection: _infiniteAxis,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Text('Infinite item $index'),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Infinite scroll view',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text('Infinite list view direction'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Text('Vertical'),
                            Radio(
                                value: Axis.vertical,
                                groupValue: _infiniteAxis,
                                onChanged: (Axis? value) {
                                  setState(() {
                                    _infiniteAxis = value!;
                                  });
                                })
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Horizontal'),
                            Radio(
                                value: Axis.horizontal,
                                groupValue: _infiniteAxis,
                                onChanged: (Axis? value) {
                                  setState(() {
                                    _infiniteAxis = value!;
                                  });
                                })
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      case ListViewType.Wheel:
        return SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            height: screenHeight,
            width: screenWidth,
            child: Column(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight / 2,
                  child: ListWheelScrollView(
                    controller: _wheelScrollController,
                    itemExtent: 48.0,
                    diameterRatio: 1.5,
                    offAxisFraction: _wheelOffAxisFractionValue,
                    children: _generateListWheel(),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const Text(
                        'List wheel scroll view',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('Drag to change offAxisFraction value'),
                      Slider(
                          value: _wheelOffAxisFractionValue,
                          min: -1.0,
                          max: 1.0,
                          onChanged: (double value) {
                            setState(() {
                              _wheelOffAxisFractionValue = value;
                            });
                          }),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Wheel item count'),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 32,
                            width: screenWidth / 3,
                            child: TextField(
                              controller: _wheelItemCountTextController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              final int count = int.parse(
                                  _wheelItemCountTextController.text.trim());
                              if (count >= 0) {
                                setState(() {
                                  _wheelItemCount = count.toDouble();
                                  _generateListWheel();
                                  _scrollController.animateTo(0.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
                                  _wheelScrollController.animateTo(0.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeOut);
                                  FocusScope.of(context).unfocus();
                                  _wheelItemCountTextController.clear();
                                });
                              }
                            },
                            child: const Text('Apply'),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        );
      default:
        return const SizedBox();
    }
  }

  void _changeListViewType(ListViewType newType) {
    setState(() {
      _type = newType;
    });
    print('Current type:$_type');
  }

  List<Widget> _generateListWheel() {
    return List<Widget>.generate(
      _wheelItemCount.toInt(),
      (index) => ListTile(
        onTap: () {
          print('Wheel item $index');
        },
        leading: const Icon(Icons.star, size: 48),
        title: Text('List wheel scroll view item $index'),
      ),
    );
  }
}

enum ListViewType { Normal, Infinity, Wheel }
