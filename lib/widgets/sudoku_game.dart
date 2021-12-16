import 'package:flutter/material.dart';
import 'package:sudoku/model/sudoku_model.dart';
import 'package:sudoku/widgets/winning_screen.dart';
import 'package:sudoku_api/sudoku_api.dart';
import 'package:provider/provider.dart';
import 'num_pad.dart';
import 'sudoku_board.dart';

class SudokuGame extends StatelessWidget {
  const SudokuGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAnyCellSelected = context.watch<SudokuModel>().selectedPoint == null;
    bool isWon = context.watch<SudokuModel>().gameWon;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(alignment: AlignmentDirectional.center, children: [
          SudokuBoard(),
          Visibility(visible: !isAnyCellSelected && !isWon, child: NumPad()),
          Visibility(visible: isWon, child: WinningScreen())
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Text('Reset')),
            SizedBox(
              width: 10,
            ),
            Container(child: Text('Generate New')),
          ],
        )
      ],
    );
  }
}
