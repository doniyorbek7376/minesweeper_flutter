import 'package:flutter/material.dart';
import 'package:minesweeper/viewmodels/mine_field_viewmodel.dart';
import 'package:minesweeper/viewmodels/mine_viewmodel.dart';

import '../theme.dart';

class MineWidget extends StatelessWidget {
  final Function gameOver;
  final int row, column;
  final MineFieldViewModel fieldModel;
  final MineViewModel model;
  const MineWidget({
    Key key,
    @required this.row,
    @required this.column,
    @required this.fieldModel,
    @required this.gameOver,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: model.stream,
      initialData: MineState.Unflagged,
      builder: (_, snapshot) {
        if (snapshot.data == MineState.Mine) gameOver();
        print(snapshot);
        if (snapshot.data == MineState.Zero)
          fieldModel.mineSink.add(Pos(row, column));
        return Container(
          decoration: BoxDecoration(
            color: colors[snapshot.data],
            // image: DecorationImage(
            //   image: AssetImage(
            //     image[snapshot.data],
            //   ),
            // ),
          ),
          child: RaisedButton(
            elevation: _isClosed(snapshot) ? 5 : 0,
            onLongPress: (){
                if(!_isClosed(snapshot)){
                  fieldModel.mineSink.add(Pos(row, column));
                }
              _onLongPress();
              },
            onPressed: _onPressed,
            child: SizedBox(
              child: Text(image[snapshot.data]),
              height: 20,
              width: 20,
            ),
          ),
        );
      },
    );
  }

  bool _isClosed(AsyncSnapshot snapshot) =>
      snapshot.data == MineState.Flagged ||
      snapshot.data == MineState.Unflagged;

  void _onLongPress() {
    
    switch (fieldModel.state) {
      case ClickState.Flag:
        model.sink.add(MineEvent.Open);
        break;
      case ClickState.Open:
        model.sink.add(MineEvent.Flag);
        break;
    }
  }
  void _onPressed() {
    switch (fieldModel.state) {
      case ClickState.Flag:
        model.sink.add(MineEvent.Flag);
        break;
      case ClickState.Open:
        model.sink.add(MineEvent.Open);
        break;
    }
  }
}
