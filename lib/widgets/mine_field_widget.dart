import 'package:flutter/material.dart';
import 'package:minesweeper/models/mine_field.dart';
import 'package:minesweeper/theme.dart';
import 'package:minesweeper/viewmodels/mine_field_viewmodel.dart';
import 'package:minesweeper/widgets/mine_widget.dart';

class MineFieldWidget extends StatefulWidget {
  final MineField field;

  const MineFieldWidget({Key key, this.field}) : super(key: key);

  @override
  _MineFieldWidgetState createState() => _MineFieldWidgetState();
}

class _MineFieldWidgetState extends State<MineFieldWidget> {
  MineFieldViewModel model;
  Difficulty difficulty;
  int a;
  @override
  void initState() {
    difficulty = Difficulty.Normal;
    a = 0;
    super.initState();
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (a == 0) {
      if (model != null) model.dispose();
      a++;
      widget.field.column = (MediaQuery.of(context).size.width / 30).truncate();
      widget.field.row =
          (MediaQuery.of(context).size.height / 30).truncate() - 3;
      widget.field.mines =
          widget.field.column * widget.field.row ~/ minesRatio[difficulty];
      widget.field.generate();
      model = new MineFieldViewModel(widget.field);
      model.newGame();
      model.minesCountSink.add(0);
    }
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
            child: DropdownButton<Difficulty>(
              underline: Container(),
              elevation: 5,
              dropdownColor: Colors.lightBlue,
              hint: Text(difficulty.toString().split(".")[1],
                  style: TextStyle(color: Colors.white)),
              items: Difficulty.values
                  .map(
                    (e) => DropdownMenuItem<Difficulty>(
                      child: Text(e.toString().split(".")[1]),
                      value: e,
                    ),
                  )
                  .toList(),
              onChanged: (Difficulty value) {
                setState(() {
                  a = 0;
                  difficulty = value;
                });
              },
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: StreamBuilder(
              stream: model.minesCount,
              initialData: 0,
              builder: (_, snapshot) {
                return Text("🚩 ${snapshot.data}");
              },
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: model.newGame,
          ),
          IconButton(
            icon: model.state == ClickState.Flag
                ? Icon(Icons.flag, color: Colors.white)
                : Image(
                    image: AssetImage("assets/images/shovel.png"),
                  ),
            onPressed: () {
              if (model.state == ClickState.Open)
                model.state = ClickState.Flag;
              else {
                model.state = ClickState.Open;
              }
              setState(() {});
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
            addRepaintBoundaries: false,
            crossAxisCount: widget.field.column,
            children:
                List.generate(widget.field.row * widget.field.column, (index) {
              var col = index % widget.field.column;
              var row = index ~/ widget.field.column;
              return MineWidget(
                column: col,
                row: row,
                fieldModel: model,
                model: model.getMineViewmodel(row, col),
                gameOver: model.gameOver,
              );
            })),
      ),
    );
  }
}
