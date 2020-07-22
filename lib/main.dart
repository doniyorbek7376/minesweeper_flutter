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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MineFieldWidget(
        field: MineField(
          row: 10,
          column: 10,
          mines: 20,
        ),
      ),
    );
  }
}
