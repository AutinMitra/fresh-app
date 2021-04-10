import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh/theme/palette.dart';

// Text Field to be used by multiple forms in TwoTP
class AdvancedFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function validator;
  final Function onChanged;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final bool enabled;

  AdvancedFormTextField(
      {this.controller,
      this.keyboardType,
      this.validator,
      this.onChanged,
      this.enabled,
      this.hintText = "",
      this.labelText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    const tStyle = TextStyle(color: Palette.text);

    return Stack(
      children: [
        TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          enabled: enabled,
          style: tStyle,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            filled: true,
            fillColor: Palette.bg,
            hintStyle: tStyle,
            contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 84),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
          onChanged: onChanged,
        ),
        Container(
          height: 69,
          width: 69,
          decoration: BoxDecoration(
            color: Palette.text,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Center(
            child: Icon(Icons.add_link, color: Palette.bg),
          ),
        ),
      ],
    );
  }
}
