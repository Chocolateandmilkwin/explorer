import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'file_list.dart';

File file = File('lib/main.dart');

void main() {
  runApp(const MyApp(
      title: 'Flutter Demo Home Page', path: 'C:\\Git\\Chocolateandmilkwin'));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title, required this.path});
  final String title;
  final String path;
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  String? _selectedDirectory;
  List<FileSystemEntity> _files = [];

  set selectedDirectory(String? value) {
    setState(() {
      _selectedDirectory = value;
      _files = value != null ? Directory(value).listSync() : [];
    });
  }

  Future<void> _pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      setState(() {
        this.selectedDirectory = selectedDirectory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 10,
        ),
        body: Column(
          children: [
            Text(_selectedDirectory ?? 'No directory selected'),
            FileList(
                files: _files.map((file) {
              return BrowserFileInfo.fromFile(file);
            }).toList()),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: _pickFolder),
      ),
    );
  }
}
