import 'dart:io';
import 'package:face_detect_google/util/screen_mode.dart';
import 'package:camera/camera.dart';
import 'package:face_detect_google/util/face_detector_painter.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

import 'camera_view.dart';

class FaceDetectorPage extends StatefulWidget {
  const FaceDetectorPage({super.key});

  @override
  State<FaceDetectorPage> createState() => _FaceDetectorPageState();
}

class _FaceDetectorPageState extends State<FaceDetectorPage> {

  /// create a face detector object
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
    enableContours: true,
    enableClassification: true,
    ),
  );

  bool _canProcess=true;
  bool _isBusy=false;
  CustomPaint? _customPaint;
  String? _text;

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Camera view',
      customPaint: _customPaint,
      text: _text,
      onImage: (inputImage){
        processImage(inputImage);
      },
      initialDirection: CameraLensDirection.front,
    );
  }
  Future<void>processImage(final InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final faces = await _faceDetector.processImage(inputImage);

    if (inputImage.metadata?.size != null &&
    inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
          faces, inputImage.metadata!.size,
          inputImage.metadata!.rotation);
      _customPaint = CustomPaint(painter: painter,);
    } else {
      String text = 'face found: ${faces.length}\n\n';
      for (final face in faces) {
        text += 'face=${face.boundingBox}\n\n';
      }
      _text = text;
      _customPaint = null;
    }
    _isBusy=false;
    if (mounted) {
      setState(() {});
    }
  }
}
