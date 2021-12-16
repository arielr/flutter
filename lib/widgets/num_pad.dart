import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sudoku/model/sudoku_model.dart';

class NumPad extends StatelessWidget {
  const NumPad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: 0.9,
            child: Container(
                padding: EdgeInsets.all(8.0),
                // width: MediaQuery.of(context).size.width * 0.5,
                color: Colors.deepPurpleAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(children: [
                      createDigit(1, context),
                      createDigit(2, context),
                      createDigit(3, context)
                    ]),
                    Row(children: [
                      createDigit(4, context),
                      createDigit(5, context),
                      createDigit(6, context)
                    ]),
                    Row(
                      children: [
                        createDigit(7, context),
                        createDigit(8, context),
                        createDigit(9, context)
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        var sudokuModel = context.read<SudokuModel>();
                        sudokuModel.setValue(0);
                        sudokuModel.clearSelected();
                      },
                      child: Container(
                        margin: EdgeInsets.all(4),
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            color: Colors.lightBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Center(
                          child: Text(('X').toString(),
                              style: TextStyle(
                                fontSize: 40,
                              )),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget createDigit(int number, BuildContext context) {
    return GestureDetector(
      onTap: () {
        var sudokuModel = context.read<SudokuModel>();
        sudokuModel.setValue(number);
        sudokuModel.clearSelected();
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 70,
        decoration: BoxDecoration(
            border: Border.all(width: 2),
            color: Colors.lightBlue,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text((number).toString(),
              style: TextStyle(
                fontSize: 40,
              )),
        ),
      ),
    );
  }
}
