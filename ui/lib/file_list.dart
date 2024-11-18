import 'dart:io';

import 'package:flutter/material.dart';

class BrowserFileInfo {
  BrowserFileInfo({required this.path, required this.modified, this.size})
      : name = _extractNameFromPath(path);
  final String path;
  final String name;
  final DateTime modified;
  final int? size;

  static String _extractNameFromPath(String path) {
    return path.split('/').last; // Adjust this based on your path format
  }

  static BrowserFileInfo fromFile(FileSystemEntity file) {
    return BrowserFileInfo(path: file.path, modified: file.statSync().modified);
  }

  String getInfoByID(int id) {
    switch (id) {
      case 0:
        return path;
      case 1:
        return name;
      case 2:
        return size.toString();
      case 3:
        return modified.toString();
      default:
        return '';
    }
  }
}

class FileList extends StatefulWidget {
  const FileList({super.key, required this.files});
  final List<BrowserFileInfo> files;
  @override
  State<FileList> createState() => _FileList();
}

class _FileList extends State<FileList> {
  int? _indexHover;
  int? _indexSelected;
  final List<BrowserListColumn> _cols = [
    const BrowserListColumn(title: 'Name', width: 300, id: 1),
    const BrowserListColumn(title: 'Size', width: 150, id: 0),
    const BrowserListColumn(title: 'Modified', width: 200, id: 3),
  ];

  set indexSelected(int? value) {
    setState(() {
      _indexSelected = value;
    });
  }

  set indexHover(int? value) {
    setState(() {
      _indexHover = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: _cols
                  .fold(50, (combine, col) => combine + col.width)
                  .toDouble(),
              child: ListView(
                children: widget.files
                    .map((fileInfo) =>
                        BrowserListLine(fileinfo: fileInfo, cols: _cols))
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BrowserListColumn {
  const BrowserListColumn(
      {required this.title, required this.width, required this.id});
  final String title;
  final int width;
  final int id;
}

class BrowserListLine extends StatefulWidget {
  const BrowserListLine(
      {super.key, required this.fileinfo, required this.cols});
  final BrowserFileInfo fileinfo;
  final List<BrowserListColumn> cols;

  @override
  State<BrowserListLine> createState() => _BrowserListLineState();
}

class _BrowserListLineState extends State<BrowserListLine> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: GestureDetector(
        child: MouseRegion(
          child: Row(
            children: widget.cols.map((col) {
              return Container(
                width: col.width.toDouble(),
                child: Text(
                  widget.fileinfo.getInfoByID(col.id),
                  maxLines: 1,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
