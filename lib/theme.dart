// Colors:
import 'package:flutter/material.dart';
import 'package:minesweeper/viewmodels/mine_viewmodel.dart';

Color mineCellColor = Colors.white;
var colors = {
  MineState.Zero: Colors.black,
  MineState.One: Colors.green,
  MineState.Two: Colors.green,
  MineState.Three: Colors.green,
  MineState.Four: Colors.green,
  MineState.Five: Colors.green,
  MineState.Six: Colors.green,
  MineState.Seven: Colors.orange,
  MineState.Eight: Colors.pink,
  MineState.Mine: Colors.blue,
  MineState.Flagged: Colors.red,
  MineState.Unflagged: Colors.yellow,
  
};
var image = {
  MineState.Zero: "0",
  MineState.One: "1",
  MineState.Two: "2",
  MineState.Three: "3",
  MineState.Four: "4",
  MineState.Five: "5",
  MineState.Six: "6",
  MineState.Seven: "7",
    MineState.Eight: "8",
  MineState.Mine: "-1",
  MineState.Flagged: "F",
  MineState.Unflagged: "U",
};