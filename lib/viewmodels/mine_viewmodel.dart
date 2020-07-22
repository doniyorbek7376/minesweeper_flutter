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
  Close,
}

class MineViewModel {
  Mine mine;
  final _outputController = StreamController<MineState>.broadcast();
  final _inputController = StreamController<MineEvent>();
  Stream<MineState> get stream => _outputController.stream;
  Sink<MineEvent> get sink => _inputController.sink;

  MineViewModel({@required this.mine}) {
    _inputController.stream.listen(onEvent);
  }

  void dispose() {
    _outputController.close();
    _inputController.close();
  }

  void onEvent(MineEvent event) {
    
    switch (event) {
      case MineEvent.Close:
        mine.isOpen = false;
        mine.isFlagged = false;
        _sendState(MineState.Unflagged);    
        break;
      case MineEvent.Open:
      if(mine.isOpen) return;
        mine.isOpen = true;
        if (mine.mines == -1) {
          _sendState(MineState.Mine);
        } else {
          _sendState(MineState.values[mine.mines]);
        }
        break;
      case MineEvent.Flag:
        if(mine.isOpen) return;
        mine.isFlagged = !mine.isFlagged;
        _sendState(mine.isFlagged ? MineState.Flagged : MineState.Unflagged);
        break;
    }
  }

  void _sendState(MineState state) {
    _outputController.sink.add(state);
  }
}
