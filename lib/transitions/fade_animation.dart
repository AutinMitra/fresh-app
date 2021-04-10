import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _FadeProps {opacity, translateY}

// props to https://stackoverflow.com/questions/62398085/fadeanimation-code-errors-while-trying-to-update-simple-animations-2-2-1-after
class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final double translateY;
  final double duration;

  FadeAnimation({@required this.delay, @required this.child, this.translateY=30, this.duration=500})
  : assert(delay != null),
    assert(child != null);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_FadeProps>()
        ..add(_FadeProps.opacity, 0.0.tweenTo(1.0), 500.milliseconds)
        ..add(_FadeProps.translateY, (this.translateY).tweenTo(0), 500.milliseconds, Curves.easeOut);

    return PlayAnimation(
      tween: tween,
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_FadeProps.opacity),
        child: Transform.translate(
            offset: Offset(0, value.get(_FadeProps.translateY)), child: child),
      ),
    );
  }
}