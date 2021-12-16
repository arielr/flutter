import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku/model/sudoku_model.dart';
import 'dart:math';
import 'sudoku_cell.dart';
import 'package:provider/provider.dart';

class SudokuBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sudokuSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          FittedBox(
            child: Container(
              height: sudokuSize,
              width: sudokuSize,
              color: Colors.lightBlueAccent,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 9,
                  crossAxisSpacing: 0,
                ),
                itemBuilder: itemBuilder,
                itemCount: 9 * 9,
                padding: EdgeInsets.all(0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    int row = (index / 9).floor();
    int col = index % 9;
    var selected = context.read<SudokuModel>().getSelected();
    Color color = selected != null &&
            (selected.x.round() == row || selected.y.round() == col)
        ? Colors.green.shade100
        : Colors.white;
    return SudokuCell(
        row, col, color, context.read<SudokuModel>().isPredefine(row, col));
  }
}
