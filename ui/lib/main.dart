import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_tabbar/reorderable_tabbar.dart';

File file = File('lib/main.dart');

void main() {
  runApp(Home());
}

class ExplorerTab {
  ExplorerTab({required this.title});
  String title;
  String path = '';
}

class Controller extends GetxController {
  List<ExplorerTab> tabs = [ExplorerTab(title: 'First')].obs;
  void addTab() {
    tabs.add(ExplorerTab(title: tabs.length.toString()));
  }

  void reorder(int oldIndex, int newIndex) {
    final item = tabs.removeAt(oldIndex);
    tabs.insert(newIndex, item);
  }
}

class Home extends StatelessWidget {
  Home({super.key});
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Obx(
      () => DefaultTabController(
          length: controller.tabs.length,
          child: Scaffold(
            appBar: ReorderableTabBar(
              isScrollable: true,
              buildDefaultDragHandles: false,
              tabs: controller.tabs
                  .map((e) => Tab(
                        child: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              Text(e.title),
                              IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    controller.tabs.remove(e);
                                  })
                            ],
                          ),
                        ),
                      ))
                  .toList(),
              onReorder: (p0, p1) => controller.reorder(p0, p1),
            ),
            body: TabBarView(
                children: controller.tabs
                    .map((e) => Browser(title: e.title))
                    .toList()),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.addTab();
              },
              child: Icon(Icons.add),
            ),
          )),
    ));
  }
}

class Browser extends StatelessWidget {
  const Browser({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 40,
            color: Color.fromARGB(255, 255, 0, 221),
            child: Row(
              children: [Text(title)],
            )),
        Container(
            height: 40,
            color: Color(0xffe0e0e0),
            child: Row(
              children: [Text(title)],
            )),
        Expanded(
            child: Row(
          children: [
            Container(
              width: 200,
              color: Color.fromARGB(255, 206, 46, 46),
              child: Text(title),
            ),
            Expanded(
              child: Container(
                  color: Color.fromARGB(255, 20, 130, 46), child: Text(title)),
            )
          ],
        )),
        Container(
            height: 20,
            color: Color(0xffe0e0e0),
            child: Row(
              children: [Text(title)],
            )),
      ],
    );
  }
}
