import 'package:flutter/material.dart';
import 'package:minesweeper/models/mine_field.dart';
import 'package:minesweeper/widgets/mine_field_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: MineFieldWidget(
        field: MineField(),
      ),
    );
  }
}
