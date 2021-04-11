import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh/bloc/baselink/baselink_bloc.dart';
import 'package:fresh/bloc/baselink/baselink_event.dart';
import 'package:fresh/components/button.dart';
import 'package:fresh/components/text_fields.dart';
import 'package:fresh/theme/palette.dart';
import 'package:fresh/transitions/fade_animation.dart';
import 'package:validators/validators.dart';

class LinkPage extends StatefulWidget {
  @override
  _LinkPageState createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  TextEditingController _linkController = TextEditingController();

  String validateHTTP(String text) {
    return !isURL(text) ? "Please input a valid link" : null;
  }

  void submitLink() {
    if(_formKey.currentState.validate()) {
      var uri = _linkController.text;

      final BaseLinkBloc baseLinkBloc = BlocProvider.of<BaseLinkBloc>(context);
      baseLinkBloc.add(BaseLinkChangeEvent(uri));

      // TODO: Add url to BloC
      Navigator.pushNamedAndRemoveUntil(context, '/ready', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: TextStyle(color: Palette.text),
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            _textHeader(),
            SizedBox(height: 72),
            _linkInput(),
            SizedBox(height: 37),
            _continueButton(),
          ],
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
            "Let's get some info",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32, color: Palette.primary),
          ),
          SizedBox(height: 12),
          Text(
            "Enter the link to the organization you wish to record data for.",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      ),
    );
  }

  Widget _linkInput() {
    return FadeAnimation(
      delay: 0.8,
      child: Form(
        key: _formKey,
        child: AdvancedFormTextField(
          hintText: "https://my-link.com",
          controller: _linkController,
          validator: validateHTTP,
        ),
      ),
    );
  }

  Widget _continueButton() {
    return FadeAnimation(
        delay: 1.1,
        child: CustomRaisedButton(child: Text("Continue"), onTap: submitLink)
    );
  }
}