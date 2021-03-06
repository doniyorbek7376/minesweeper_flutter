import 'dart:math';

import 'package:minesweeper/models/mine.dart';

class MineField {
  int row=0, column=0, mines=0;
  var _listInt = List<List<int>>();
  var _listMine = List<List<Mine>>();

  MineField({this.row=0, this.column=0, this.mines=0}) {
    generate();
  }

  Mine getMine(int r, int c) {
    if (r < row && c < column) return _listMine[r][c];
    return null;
  }

  void generate() {
    _listInt = List.generate(row, (r) => List.generate(column, (c) => 0));
    int i = 0;
    var rand = Random(
      DateTime.now().millisecondsSinceEpoch,
    );
    while (i < mines) {
      int r = rand.nextInt(row);
      int c = rand.nextInt(column);
      if (_listInt[r][c] != -1) {
        _listInt[r][c] = -1;
        i++;
      }
    }
    for (int i = 0; i < row; i++) {
      for (int j = 0; j < column; j++) {
        if (_listInt[i][j] != -1) {
          _listInt[i][j] = _numberOfMines(i, j);
        }
      }
    }
    _populateListMines();
  }

  int _numberOfMines(int r, int c) {
    int sum = 0;
    for (int i = r - 1; i <= r + 1; i++) {
      for (int j = c - 1; j <= c + 1; j++) {
        if (i >= 0 && j >= 0 && i < row && j < column) {
          if (_listInt[i][j] == -1) {
            sum++;
          }
        }
      }
    }
    return sum;
  }
  int flaggedCount(){
    var c = 0;
    _listMine.forEach((element) {element.forEach((e) { if(e.isFlagged) c++; });});
    return c;
  }
  void _populateListMines() {
    _listMine = List.generate(
      row,
      (r) => List.generate(
        column,
        (c) => Mine(
          mines: _listInt[r][c],
        ),
      ),
    );
  }
}
