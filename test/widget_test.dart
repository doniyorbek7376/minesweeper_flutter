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
