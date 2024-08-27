import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ['xlsx']);
                print(result?.files?.first.name);
                if (result != null) {
                  var bytes = result.files.first.bytes;
                  var excel = Excel.decodeBytes(bytes as List<int>);
                  for (var table in excel.tables.keys) {
                    print("table: $table"); //sheet Name
                    print("maxColumn: ${excel.tables[table]?.maxColumns} ");
                    print("maxRows: ${excel.tables[table]?.maxRows}");
                    for (var row in excel.tables[table]!.rows) {
                      for (var cell in row) {
                        print(
                            'cell ${cell?.rowIndex}/${cell?.columnIndex}: ${cell?.value}');
                      }
                    }
                  }
                }
              },
              child: const Text("Import File Product")),
        ),
      ),
    );
  }
}
