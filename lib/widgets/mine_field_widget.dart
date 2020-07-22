import 'package:flutter/material.dart';
import 'package:minesweeper/models/mine_field.dart';
import 'package:minesweeper/viewmodels/mine_field_viewmodel.dart';
import 'package:minesweeper/widgets/mine_widget.dart';


import '../settings_screen.dart';

class MineFieldWidget extends StatefulWidget {
  final MineField field;

  const MineFieldWidget({Key key, this.field}) : super(key: key);

  @override
  _MineFieldWidgetState createState() => _MineFieldWidgetState();
}

class _MineFieldWidgetState extends State<MineFieldWidget> {
  MineFieldViewModel model;

  @override
  void initState() {
    model = new MineFieldViewModel(widget.field);
    super.initState();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
            icon: Icon(Icons.settings),
          ),
          IconButton(
            icon: Icon(Icons.flag),
            onPressed: () {
              if (model.state == ClickState.Open)
                model.state = ClickState.Flag;
              else {
                model.state = ClickState.Open;
              }
            },
          )
        ],
      ),
      body: Column(
        children: List<Widget>.generate(
          widget.field.row,
          (row) => Row(
          children: List<Widget>.generate(
            widget.field.column,
            (col) => Expanded(
              child: MineWidget(
                model: model.getMineViewmodel(row, col),
                column: col,
                row: row,
                fieldModel: model,
                gameOver: gameOver,
              ),
            ),
          ),
          )
        ),
      ),
    );
  }

  void gameOver() {
    // ignore: todo
    //TODO: Show a dialog about gameOver
    model.gameOver();
  }
}
