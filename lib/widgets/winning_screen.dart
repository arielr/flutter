import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/model/sudoku_model.dart';

class WinningScreen extends StatelessWidget {
  const WinningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            'YOU WON!',
            style: TextStyle(fontSize: 30),
          ),
          TextButton(
            onPressed: () {
              context.read<SudokuModel>().initNewGame();
            },
            child: Text('Restart'),
          )
        ],
      ),
    );
  }
}
