import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_tabbar/reorderable_tabbar.dart';

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
          animationDuration: Duration(milliseconds: 1),
          length: controller.tabs.length,
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(142),
                child: Column(
                  children: [
                    ReorderableTabBar(
                      isScrollable: true,
                      buildDefaultDragHandles: false,
                      padding: const EdgeInsets.all(0),
                      tabs: controller.tabs
                          .map((e) => Tab(
                                height: 50,
                                child: Container(
                                  color: Color(0xffe0e0e0),
                                  width: 200,
                                  height: 50,
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
                    Container(
                        height: 45,
                        color: const Color.fromARGB(255, 255, 0, 221),
                        child: const Row(
                          children: [Text('title')],
                        )),
                    Container(
                        height: 45,
                        color: const Color(0xffe0e0e0),
                        child: const Row(
                          children: [Text('title')],
                        )),
                  ],
                )),

            // AppBar(
            //   toolbarHeight: 200,
            //   flexibleSpace: Column(
            //     children: [
            //

            //     ],
            //   ),
            // ),
            body: TabBarView(
                children: controller.tabs
                    .map((e) => Browser(title: e.title))
                    .toList()),
            bottomNavigationBar: Container(
                height: 20,
                color: const Color(0xffe0e0e0),
                child: const Row(
                  children: [Text('title')],
                )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.addTab();
              },
              child: const Icon(Icons.add),
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
    return Row(
      children: [
        Container(
          width: 200,
          color: const Color.fromARGB(255, 206, 46, 46),
          child: SizedBox.expand(child: Text(title)),
        ),
        Expanded(
          child: SizedBox.expand(
            child: Container(
                color: const Color.fromARGB(255, 20, 130, 46),
                child: Text(title)),
          ),
        )
      ],
    );
  }
}
