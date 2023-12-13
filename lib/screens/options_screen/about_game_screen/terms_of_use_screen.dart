import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/game_colors.dart';
import '../../../utils/game_sizes.dart';
import '../../../utils/game_text_styles.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.loadFlutterAsset('assets/html/legal_terms.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        backgroundColor: GameColors.appBarBackground,
        title: Text(
          'Terms of Use',
          style: GameTextStyles.optionsScreenAppBarTitle
              .copyWith(fontSize: GameSizes.getWidth(0.045)),
        ),
        leading: const BackButton(),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
