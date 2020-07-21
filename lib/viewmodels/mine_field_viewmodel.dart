import 'dart:async';

import 'package:minesweeper/models/mine_field.dart';
import 'package:minesweeper/viewmodels/mine_viewmodel.dart';

class Pos {
  final int row, column;
  Pos(this.row, this.column);
}

enum ClickState {
  Flag,
  Open,
}

class MineFieldViewModel {
  ClickState state = ClickState.Open;
  final MineField field;
  var _viewmodels = List<List<MineViewmodel>>();
  var _mineOpenerController = StreamController<Pos>();
  var _clickStateChangerController = StreamController<ClickState>();

  MineFieldViewModel(this.field) {
    _mineOpenerController.stream.listen((event) {
      for (int i = event.row - 1; i < event.row + 2; i++) {
        for (int j = event.column - 1; j < event.column + 2; j++) {
          try {
            var model = getMineViewmodel(i, j);
            model.sink.add(MineEvent.Open);
          } catch (e) {
            print(e);
          }
        }
      }
    });

    _clickStateChangerController.stream.listen((event) {
      state = event;
    });
  }
  Sink<Pos> get mineSink => _mineOpenerController.sink;
  Sink<ClickState> get stateSink => _clickStateChangerController.sink;

  MineViewmodel getMineViewmodel(int r, int c) => _viewmodels[r][c];

  void dispose() {
    _viewmodels.forEach((row) => row.forEach((model) => model.dispose()));
    _clickStateChangerController.close();
    _mineOpenerController.close();
  }
}
