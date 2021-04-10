import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _SlideProps { translateY }

// props to https://stackoverflow.com/questions/62398085/fadeanimation-code-errors-while-trying-to-update-simple-animations-2-2-1-after
class SlideAnimation extends StatelessWidget {
  final double delay;
  final Widget child;
  final double translateY;
  final double duration;

  SlideAnimation(
      {@required this.delay,
      @required this.child,
      this.translateY = 30,
      this.duration = 500})
      : assert(delay != null),
        assert(child != null);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_SlideProps>()
      ..add(_SlideProps.translateY, (this.translateY).tweenTo(0),
          500.milliseconds, Curves.easeOut);

    return PlayAnimation(
      tween: tween,
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      child: child,
      builder: (context, child, value) => Transform.translate(
          offset: Offset(0, value.get(_SlideProps.translateY)), child: child),
    );
  }
}
