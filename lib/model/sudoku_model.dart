import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/model/sudoku_cell_info.dart';
import 'package:sudoku_api/sudoku_api.dart';

class SudokuModel extends ChangeNotifier {
  int validCellsCount = 0;
  bool gameWon = false;
  late List<List<SudokuCellInfo>> board;
  Point? selectedPoint;

  void listener;

  SudokuModel() {
    initNewGame();
  }

  void initNewGame() {
    board = generateEmptyBoard();
    validCellsCount = 0;
    gameWon = false;
    selectedPoint = null;

    Puzzle puzzle = Puzzle(PuzzleOptions());
    puzzle.generate().then((value) {
      puzzle.board().matrix().expand((i) => i).forEach((cell) {
        int row = cell.position.grid.x.toInt();
        int col = cell.position.grid.y.toInt();
        int value = cell.getValue().toInt();

        if (value != 0) {
          validCellsCount++;
        }
        board[row][col] = SudokuCellInfo(Colors.white, value, value == 0);
      });
      notifyListeners();
      printGrid(puzzle.solvedBoard());
    });
  }

  void setValue(int value) {
    if (selectedPoint == null) return;

    int row = selectedPoint?.x?.round() as int;
    int col = selectedPoint?.y?.round() as int;

    board[row][col].value = value;
    checkWinning();
    notifyListeners();
  }

  bool isCellValid(int row, int col) {
    int? value = getValue(row, col);
    if (value == null) {
      return true;
    }

    for (int i = 0; i < 9; i++) {
      if (board[i][col].value != 0 &&
          i != row &&
          board[i][col].value == value.toInt()) {
        return false;
      }
      if (board[row][i].value != 0 &&
          i != col &&
          board[row][i].value == value.toInt()) {
        return false;
      }
    }

    return true;
  }

  void setSelectedCell(int row, int col) {
    selectedPoint = Point(row, col);
    notifyListeners();
  }

  void clearSelected() {
    selectedPoint = null;
    notifyListeners();
  }

  Point? getSelected() {
    return selectedPoint;
  }

  int? getValue(int row, int col) {
    return board[row][col].value;
  }

  bool isPredefine(int row, int col) {
    return board[row][col].isChangeable;
  }

  List<List<SudokuCellInfo>> generateEmptyBoard() => List.generate(
      9,
      (index) =>
          List.generate(9, (index) => SudokuCellInfo(Colors.white, 0, false)));

  void checkWinning() {
    if (board.expand((i) => i).any((cell) => cell.value.toInt() == 0)) {
      gameWon = false;
      return;
    }

    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (!isCellValid(i, j)) {
          gameWon = false;
          return;
        }
      }
    }

    gameWon = true;
  }
}
