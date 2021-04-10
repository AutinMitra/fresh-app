import 'package:flutter/material.dart';
import 'package:fresh/components/button.dart';
import 'package:fresh/theme/palette.dart';
import 'package:fresh/transitions/fade_animation.dart';

class HomePage extends StatelessWidget {
  void goToLinkPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, '/link', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        child: DefaultTextStyle(
          style: TextStyle(color: Palette.text),
          child: SafeArea(
            child: Stack(
              children: [
                _textHeader(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _waterBottle(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: _continueButton(context),
                  )
                )
              ],
            )
          ),
        ),
      ),
    );
  }

  Widget _textHeader() {
    return FadeAnimation(
      delay: 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 72),
          Text(
            "Fresh.",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 48, color: Palette.primary),
          ),
          SizedBox(height: 8),
          Text(
            "Let's help our scientists clean the world, one bottle at a time.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      ),
    );
  }

  Widget _waterBottle() {
    return FadeAnimation(
      delay: 0.8,
      translateY: 150,
      child: Image(
        image: new AssetImage("assets/graphics/bottle.png"),
      ),
    );
  }

  Widget _continueButton(context) {
    return FadeAnimation(
      delay: 1.1,
      child: CustomRaisedButton(
        child: Text("Get Started"),
        onTap: () {
          goToLinkPage(context);
        },
      ),
    );
  }
}