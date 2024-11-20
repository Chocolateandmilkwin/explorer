import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

File file = File('lib/main.dart');

void main() => runApp(GetMaterialApp(home: Home()));

class Controller extends GetxController {
  var count = 0;
  increment() {
    count++;
    update();
  }
}

class Home extends StatelessWidget {
  Home({super.key});

  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<Controller>(
                builder: (_) => Text(
                      'clicks: ${controller.count}',
                    )),
            ElevatedButton(
              child: const Text('Next Route'),
              onPressed: () {
                Get.to(Second());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Second extends StatelessWidget {
  final Controller ctrl = Get.find();
  @override
  Widget build(context) {
    return Scaffold(body: Center(child: Text("${ctrl.count}")));
  }
}


// void main() {
//   runApp(const MyApp(
//       title: 'Flutter Demo Home Page', path: 'C:\\Git\\Chocolateandmilkwin'));
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key, required this.title, required this.path});
//   final String title;
//   final String path;
//   @override
//   State<MyApp> createState() => _MyApp();
// }

// class _MyApp extends State<MyApp> {
//   String? _selectedDirectory;
//   List<FileSystemEntity> _files = [];

//   set selectedDirectory(String? value) {
//     setState(() {
//       _selectedDirectory = value;
//       _files = value != null ? Directory(value).listSync() : [];
//     });
//   }

//   Future<void> _pickFolder() async {
//     String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
//     if (selectedDirectory != null) {
//       setState(() {
//         this.selectedDirectory = selectedDirectory;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       themeMode: ThemeMode.system,
//       theme: ThemeData.light(useMaterial3: true),
//       darkTheme: ThemeData.dark(useMaterial3: true),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           elevation: 10,
//         ),
//         body: Column(
//           children: [
//             Text(_selectedDirectory ?? 'No directory selected'),
//             // FileList(
//             //     files: _files.map((file) {
//             //   return BrowserFileInfo.fromFile(file);
//             // }).toList()),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(onPressed: _pickFolder),
//       ),
//     );
//   }
// }
