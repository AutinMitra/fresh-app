import 'package:flutter/material.dart';
import 'package:fresh/components/button.dart';
import 'package:fresh/theme/palette.dart';
import 'package:fresh/transitions/fade_animation.dart';

class ReadyPage extends StatelessWidget {
  void goRecord(context) {
    Navigator.pushNamed(context, '/camera');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: TextStyle(color: Palette.text),
        child: SafeArea(
            child: Stack(
              children: [
                _textHeader(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _clipBoard(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: _continueButton(context),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }

  Widget _textHeader() {
    return FadeAnimation(
      delay: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 72),
            Text(
              "Record",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 48, color: Palette.primary),
            ),
            SizedBox(height: 8),
            Text(
              "Start recording data, and help clean the environment.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )
          ],
        ),
      ),
    );
  }

  Widget _clipBoard() {
    return FadeAnimation(
      delay: 0.5,
      translateY: 250,
      child: Image(
        image: new AssetImage("assets/graphics/clipboard.png"),
      ),
    );
  }

  Widget _continueButton(context) {
    return CustomRaisedButton(
      child: Text("Start"),
      onTap: () {
        goRecord(context);
      },
    );
  }
}