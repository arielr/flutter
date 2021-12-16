import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/model/sudoku_model.dart';

class SudokuCell extends StatelessWidget {
  late int index;
  late int row = 0;
  late int col = 0;
  bool isPermanent;

  late Color color;

  SudokuCell(this.row, this.col, this.color, this.isPermanent);

  @override
  Widget build(BuildContext context) {
    var sudokuModel = context.watch<SudokuModel>();
    var fixedColor = color;

    var cellValue = sudokuModel.getValue(row, col) == 0
        ? ""
        : sudokuModel.getValue(row, col).toString();

    if (sudokuModel.getValue(row, col) != 0 &&
        sudokuModel.isPredefine(row, col)) {
      fixedColor = Colors.blue.shade100;
    }

    if (!sudokuModel.isCellValid(row, col)) {
      fixedColor = Colors.red.shade400;
    }

    return GestureDetector(
      onTap: () {
        if (!sudokuModel.isPredefine(row, col) ||
            (sudokuModel.selectedPoint?.x == row &&
                sudokuModel.selectedPoint?.y == col)) {
          sudokuModel.clearSelected();
          return;
        }

        sudokuModel.setSelectedCell(row, col);
      },
      child: Container(
          padding: EdgeInsets.all(0.0),
          decoration:
              BoxDecoration(color: fixedColor, border: getBoarder(row, col)),
          child: Center(
              child: Text(cellValue.toString(),
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  )))),
    );
  }

  getBoarder(int rowIndex, int colIndex) {
    var normalBorder = const BorderSide(width: 0.5, color: Colors.black);
    var strongBorder = const BorderSide(width: 2.0, color: Colors.black);

    return Border(
      top: [0, 3, 6].contains(rowIndex) ? strongBorder : normalBorder,
      left: [0, 3, 6].contains(colIndex) ? strongBorder : normalBorder,
      right: [2, 5, 8].contains(colIndex) ? strongBorder : normalBorder,
      bottom: [8, 2, 5].contains(rowIndex) ? strongBorder : normalBorder,
    );
  }
}
