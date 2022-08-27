import 'package:camera/camera.dart';
import 'package:communes/pages/photo.dart';
import 'package:flutter/material.dart';

/// CameraPage is the Main Application.
class CameraPage extends StatefulWidget {
  /// Default Constructor
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  late List<CameraDescription> cameras;
  void startCamera() async {
    cameras = await availableCameras();
    print(cameras);
    controller = CameraController(
      cameras[0],
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    await controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    startCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Prendre une photo"),
          backgroundColor: Colors.amber[900],
        ),
        body: Column(children: [
          Expanded(child: CameraPreview(controller)),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            controller.takePicture().then((XFile file)=>{

              if(mounted){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Photo(imagePath:file.path),
                    ))
              }
            })
          },
          backgroundColor: Colors.amber[900],
          child: Icon(
            Icons.camera, // add custom icons also
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
