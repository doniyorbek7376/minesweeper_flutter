import 'dart:async';

import 'package:flutter/foundation.dart';

import '../models/mine.dart';

enum MineState {
  Zero,
  One,
  Two,
  Three,
  Four,
  Five,
  Six,
  Seven,
  Eight,
  Mine,
  Flagged,
  Unflagged,
}

enum MineEvent {
  Open,
  Flag,
}

class MineViewmodel {
  final Mine mine;
  final _outputController = StreamController<MineState>();
  final _inputController = StreamController<MineEvent>();
  Stream<MineState> get stream => _outputController.stream;
  Sink<MineEvent> get sink => _inputController.sink;

  MineViewmodel({@required this.mine}) {
    _inputController.stream.listen(onEvent);
  }

  void dispose() {
    _outputController.close();
    _inputController.close();
  }

  void onEvent(MineEvent event) {
    if(mine.isOpen) return;
    switch (event) {
      case MineEvent.Open:
        mine.isOpen = true;
        if (mine.mines == -1) {
          _sendState(MineState.Mine);
        } else {
          _sendState(MineState.values[mine.mines]);
        }
        break;
      case MineEvent.Flag:
        
        mine.isFlagged = !mine.isFlagged;
        _sendState(mine.isFlagged ? MineState.Flagged : MineState.Unflagged);
        break;
    }
  }

  void _sendState(MineState state) {
    _outputController.sink.add(state);
  }
}
