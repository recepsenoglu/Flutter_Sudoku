import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';
import 'package:flutter_sudoku/utils/game_text_styles.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GameColors.optionsBackground,
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: GameColors.appBarBackground,
        title: Text(
          'Rules',
          style: GameTextStyles.optionsScreenAppBarTitle
              .copyWith(fontSize: GameSizes.getWidth(0.045)),
        ),
      ),
      body: SingleChildScrollView(
        padding: GameSizes.getSymmetricPadding(0.04, 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sudoku Rules',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: GameSizes.getWidth(0.05),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'The classic Sudoku game involves a grid of 81 squares. The grid is divided into nine blocks, each containing nine squares.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'The rules of the game are simple: each of the nine blocks has to contain all the numbers 1-9 within its squares. Each number can only appear once in a row, column or box.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'The difficulty lies in that each vertical nine-square column, or horizontal nine-square line across, within the larger square, must also contain the numbers 1-9, without repetition or omission.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'Every puzzle has just one correct solution.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Icon(
              Icons.circle,
              size: GameSizes.getWidth(0.025),
              color: Colors.black,
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'Tips on Solving Sudoku Puzzles',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: GameSizes.getWidth(0.05),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'Sudoku puzzles are great brain teasers that require logical thinking and a systematic approach to solve. Here are some tips on how to solve Sudoku puzzles.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'Tip 1: Look for rows, columns of 3×3 sections that contain 5 or more numbers. Work through the remaining empty cells, trying the numbers that have not been used. In many cases, you will find numbers that can only be placed in one position considering the other numbers that are already in its row, column, and 3×3 grid.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'Tip 2: Break the grid up visually into 3 columns and 3 rows. Each large column will have 3, 3×3 grids and each row will have 3, 3×3 grids. Now, look for columns or grids that have 2 of the same number. Logically, there must be a 3rd copy of the same number in the only remaining 9-cell section. Look at each of the remaining 9 positions and see if you can find the location of the missing number.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
            SizedBox(height: GameSizes.getWidth(0.025)),
            Text(
              'Tip 3: Look at each of the remaining 9 positions and see if you can find the location of the missing number. Now that you know the 9 possible numbers that can go into this cell, look at the row and see if any of those numbers are already present. If you don’t see any duplicate numbers, you can rule out those numbers for that cell. Now, look for columns or grids that have 2 of the same number. Logically, there must be a 3rd copy of the same number in the only remaining 9-cell section. Look at each of the remaining 9 positions and see if you can find the location of the missing number.',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: GameSizes.getWidth(0.038),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
