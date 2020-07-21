// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:minesweeper/models/mine_field.dart';


void main() {
  test("Mine field test", (){
    var field = MineField(
      row: 10,
      column: 10,
      mines: 20,
    );
    field.generate();

    for(int i=0;i<10;i++){
      for(int j=0;j<10;j++){
        stdout.write("${field.getMine(i, j).mines} ");
      }
      stdout.write('\n');
    }
  });
}
