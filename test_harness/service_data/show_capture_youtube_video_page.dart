import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/beta/service_data/capture_liturgy_name_page.dart';
import 'package:billiards/beta/service_data/capture_youtube_video_page.dart';
import 'package:billiards/service_data.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:flutter/material.dart';




void main() {


  showPage(
    CaptureYouTubeVideoPage(handler: PageEventHandler<CaptureYouTubeVideoOutputState>(handleCaptureLiturgyName),
      inputState: CaptureYouTubeVideoInputState('Hello'),)
  );
}

Future<Widget> handleCaptureLiturgyName(CaptureYouTubeVideoOutputState output) async {
  return Card( child: Text(output.toString()));
}