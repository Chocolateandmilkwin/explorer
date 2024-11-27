import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final test = 0.obs;
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Obx(
      () => Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(142),
            child: Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 2, left: 2, right: 2),
                  color: const Color.fromARGB(255, 22, 0, 221),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: controller.tabs
                        .map((e) => Container(
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
                            ))
                        .toList(),
                  ),
                ),
                Container(
                    height: 45,
                    color: const Color.fromARGB(255, 255, 0, 221),
                    child: Row(
                      children: [Text(test.toString())],
                    )),
                Container(
                    height: 45,
                    color: const Color(0xffe0e0e0),
                    child: const Row(
                      children: [Text('title')],
                    )),
              ],
            )),
        // body: TabBarView(
        //     children:
        //         controller.tabs.map((e) => Browser(title: e.title)).toList()),
        bottomNavigationBar: Container(
            height: 20,
            color: const Color(0xffe0e0e0),
            child: const Row(
              children: [Text('title')],
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.addTab();
            test.value++;
          },
          child: const Icon(Icons.add),
        ),
      ),
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
