import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh/bloc/baselink/baselink_bloc.dart';
import 'package:fresh/bloc/baselink/baselink_state.dart';
import 'package:fresh/components/button.dart';
import 'package:fresh/data/trashlist.dart';
import 'package:fresh/theme/palette.dart';
import 'package:tflite/tflite.dart';
import 'package:geolocator/geolocator.dart';


class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraPage({@required this.cameras}) : assert(cameras != null);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController _controller;

  bool currentlyPredicting = false;
  List<String> labels = [];
  String lastLabel = "";
  CameraImage lastImage;

  void uploadResults() async {
    if (labels.isNotEmpty) {
      _controller.stopImageStream();
      final image = await _controller.takePicture();

      // for the sake of this hackathon, let's assume that they just have it enabled : )

      var permission = await Geolocator.requestPermission();
      final Position position = await Geolocator.getCurrentPosition();

      var formData = FormData.fromMap({
        'label': labels[0],
        'lat': position.latitude.toString(),
        'lng': position.longitude.toString(),
        'file': await MultipartFile.fromFile(image?.path)
      });

      final BaseLinkBloc baseLinkBloc = BlocProvider.of<BaseLinkBloc>(context);
      final BaseLinkState state = baseLinkBloc.state;

      try {
        if (state is BaseLinkExistsState) {
          // TODO: Clean baseUrl to deal with last /
          print("${(state).baseUrl}/api/upload");
          print(image.path);
          await Dio().post("${(state).baseUrl}/api/upload", data: formData);
          // TODO: Alert user
        }
      } catch(e) {
        // hackathon any%, 0 error handling
        print(e.toString());
      }

      startPredictions();
    }
  }

  loadMobileNet() async {
    await Tflite.loadModel(
        model: "assets/tflite/mobilenet.tflite",
        labels: "assets/tflite/labels.txt");
  }

  startPredictions() async {
    _controller.startImageStream((CameraImage image) async {
      lastImage = image;
      try {
        if (!currentlyPredicting) {
          currentlyPredicting = true;
          List<dynamic> results = await Tflite.runModelOnFrame(
            bytesList: image.planes.map((plane) => plane.bytes).toList(),
            // required
            imageHeight: image.height,
            imageWidth: image.width,
            numResults: 3,
          );

          setState(() {
            labels = TrashList.isTrashGetLabel(results);
          });
          currentlyPredicting = false;
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();

    loadMobileNet();

    _controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      startPredictions();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
    _controller.stopImageStream();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTextStyle(
        style: TextStyle(color: Palette.text),
        child: Stack(
          children: [
            cameraPreview(),
            Align(alignment: Alignment.bottomCenter, child: currentLabels())
          ],
        ),
      ),
    );
  }

  Widget tagLabel(text) {
    return Container(
        margin: EdgeInsets.only(right: 4, bottom: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Palette.bg,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          text,
          style: TextStyle(color: Palette.text, fontWeight: FontWeight.bold),
        ));
  }

  Widget currentLabels() {
    return Container(
      height: 300,
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: Palette.sc,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trash Labels",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Palette.primary),
          ),
          SizedBox(
            height: 8,
          ),
          Wrap(
            children: labels.map((l) => tagLabel(l)).toList(),
          ),
          SizedBox(height: 8,),
          Expanded(child: Container()),
          if (labels.isNotEmpty)
            CustomRaisedButton(child: Text("Record & Upload"), onTap: uploadResults)
        ],
      ),
    );
  }

  Widget cameraPreview() {
    if (_controller.value.isInitialized) return CameraPreview(_controller);
    return Container();
  }
}
