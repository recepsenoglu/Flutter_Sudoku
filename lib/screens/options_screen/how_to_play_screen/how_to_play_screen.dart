import 'package:flutter/material.dart';
import 'package:flutter_sudoku/utils/game_colors.dart';
import 'package:flutter_sudoku/utils/game_sizes.dart';
import 'package:flutter_sudoku/utils/game_strings.dart';
import 'package:flutter_sudoku/widgets/button/custom_icon_button.dart';
import 'package:flutter_sudoku/widgets/button/custom_text_button.dart';

class HowToPlayScreen extends StatefulWidget {
  const HowToPlayScreen({super.key});

  @override
  State<HowToPlayScreen> createState() => _HowToPlayScreenState();
}

class _HowToPlayScreenState extends State<HowToPlayScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _loading = false;
      });
    });
  }

  void _onPageChanged(int index) {
    if (index < 0 || index > 2) return;
    setState(() {
      _currentPage = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'How to Play',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: GameSizes.getWidth(0.045),
          ),
        ),
        leading: const SizedBox(),
        actions: const [CustomTextButton(text: GameStrings.skip)],
      ),
      body: Padding(
        padding: GameSizes.getHorizontalPadding(0.015),
        child: Column(
          children: [
            Visibility(
              visible: !_loading,
              replacement: Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                      child: LinearProgressIndicator(
                        color: GameColors.appBarActions,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              child: Expanded(
                child: PageView.builder(
                    itemCount: 3,
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/how_to_play_${index + 1}.png',
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(height: GameSizes.getHeight(0.04)),
                            Padding(
                              padding: GameSizes.getHorizontalPadding(0.045),
                              child: index > 0
                                  ? Text(
                                      index == 1
                                          ? GameStrings.chooseACell
                                          : GameStrings.notesMode,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: GameSizes.getWidth(0.041),
                                      ),
                                    )
                                  : RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: GameSizes.getWidth(0.041),
                                          ),
                                          children: [
                                            const TextSpan(
                                              text:
                                                  "A Sudoku puzzle starts with a grid where certain numbers are already positioned. The objective is to fill in the remaining cells with numbers 1 to 9 so that each digit appears exactly once in every ",
                                            ),
                                            TextSpan(
                                              text: "rows",
                                              style: TextStyle(
                                                color: Colors.yellow.shade700,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(text: ", "),
                                            TextSpan(
                                              text: "columns",
                                              style: TextStyle(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(text: " and "),
                                            TextSpan(
                                              text: "3x3 boxes",
                                              style: TextStyle(
                                                color: Colors.blue.shade700,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text:
                                                  ". Examine the grid to identify the suitable numbers for each cell.",
                                            ),
                                          ]),
                                    ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
            Padding(
              padding: GameSizes.getHorizontalPadding(0.04)
                  .copyWith(bottom: GameSizes.getHeight(0.03)),
              child: Row(
                children: [
                  Opacity(
                    opacity: _currentPage == 0 ? 0 : 1,
                    child: CustomIconButton(
                      icon: Icons.arrow_back,
                      onPressed: () {
                        _onPageChanged(_currentPage - 1);
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: GameSizes.getWidth(0.02),
                      alignment: Alignment.center,
                      child: Center(
                        child: ListView.builder(
                            itemCount: 3,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: GameSizes.getWidth(0.01)),
                                width: GameSizes.getWidth(0.02),
                                height: GameSizes.getWidth(0.02),
                                decoration: BoxDecoration(
                                  color: index == _currentPage
                                      ? GameColors.appBarActions
                                      : GameColors.appBarActions
                                          .withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  if (_currentPage == 2)
                    CustomIconButton(
                      icon: Icons.check,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  else
                    CustomIconButton(
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        _onPageChanged(_currentPage + 1);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
