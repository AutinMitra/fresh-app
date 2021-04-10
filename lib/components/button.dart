import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fresh/theme/palette.dart';
import 'package:styled_widget/styled_widget.dart';

class CustomRaisedButton extends StatefulWidget {
  final Widget child;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  CustomRaisedButton({
    @required this.child,
    this.color = Palette.primary,
    this.textColor = Colors.white,
    this.onTap,
    this.onLongPress
  }) : assert(child != null);

  @override
  _CustomRaisedButtonState createState() => _CustomRaisedButtonState();
}

class _CustomRaisedButtonState extends State<CustomRaisedButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    var darkMode = Theme.of(context).brightness == Brightness.dark;

    final cardItem = ({Widget child}) => Styled.widget(child: child)
        .ripple(
          highlightColor: Colors.transparent,
          splashColor: darkMode ? Color(0x30000000) : Color(0x30FFFFFF)
        )
        .height(64)
        .backgroundColor(widget.color, animate: true)
        .clipRRect(all: 18)
        .borderRadius(all: 18)
        .gestures(
          onTapChange: (tapStatus) => setState(() => pressed = tapStatus),
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
        )
        .scale(all: pressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 150), Curves.easeOut);

    return cardItem(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        child: DefaultTextStyle(
            style: TextStyle(color: widget.textColor, fontWeight: FontWeight.bold),
            child: Center(child: widget.child)
        ),
      ),
    );
  }
}