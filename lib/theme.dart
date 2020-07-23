import 'package:flutter/material.dart';
import 'package:minesweeper/viewmodels/mine_viewmodel.dart';
Color background = Colors.blue[900];
// var background = Colors.white;
// RGB(15,1,143)
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
  MineState.Mine: "mine",
  MineState.Flagged: "flag",
  MineState.Unflagged: "u",
};