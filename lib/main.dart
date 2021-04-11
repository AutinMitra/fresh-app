import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh/bloc/baselink/baselink_bloc.dart';
import 'package:fresh/bloc/baselink/baselink_state.dart';
import 'package:fresh/theme/theme.dart';
import 'package:fresh/views/camera.dart';
import 'package:fresh/views/home.dart';
import 'package:fresh/views/link.dart';
import 'package:fresh/views/ready.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(MultiBlocProvider(
    providers: <BlocProvider>[
      BlocProvider<BaseLinkBloc>(create: (context) => BaseLinkBloc(BaseLinkNoneState()))
    ],
    child: FocusApp(),
  ));
}

class FocusApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.lightMode,
      home: HomePage(),
      routes: {
        '/link': (context) => LinkPage(),
        '/ready': (context) => ReadyPage(),
        '/camera': (context) => CameraPage(cameras: cameras)
      }
    );
  }
}
