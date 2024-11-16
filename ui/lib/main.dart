import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

File file = File('lib/main.dart');

void main() {
  runApp(const MyApp(title: 'Flutter Demo Home Page'));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title});
  final String title;
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  String? _selectedDirectory;
  List<FileSystemEntity> _files = [];
  bool _isDarkTheme = false;

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

  void _toggleTheme() {
    setState(() {
      _isDarkTheme = !_isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _isDarkTheme
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.folder),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: Column(
          children: [
            Text(_selectedDirectory ?? 'No directory selected'),
            Table(
              children: _files.map((file) {
                return TableRow(
                  children: [
                    Text(file.path),
                    Text(file.statSync().modified.toString()),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: _pickFolder),
      ),
    );
  }
}
