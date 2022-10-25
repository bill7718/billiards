import 'dart:async';
import 'package:billiards/src/service_data/you_tube_video.dart';
import 'package:billiards/data.dart';

import 'package:billiards/src/services/billiard_state.dart';
import 'package:billiards/src/journey/journey_controller.dart';

import 'package:billiards/pages.dart';

import 'package:flutter/material.dart';

import '../../src/data/data_service.dart';
import 'capture_youtube_video_page.dart';


class AddYouTube extends JourneyController {
  final DataService data;
  final BilliardState coreState;

  final AddYouTubeState state = AddYouTubeState();

  AddYouTube(this.data, this.coreState);

  @override
  PageEventHandler<void> get startHandler => PageEventHandler<void>(firstPage);

  Future<Widget> firstPage() {
    var c = Completer<Widget>();
    c.complete(CaptureYouTubeVideoPage(
      handler: PageEventHandler<CaptureYouTubeVideoOutputState>(handleCapture),
      inputState: CaptureYouTubeVideoInputState(coreState.user.email),
    ));
    return c.future;
  }

  Future<Widget> handleCapture(CaptureYouTubeVideoOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.next:
        var yt = YouTubeVideo.fromValues(coreState.organisation!.dbReference, state.name!, state.videoId!);
        var f = data.set(yt.dbReference, yt.data);
        f.then((_) {
          c.complete(BilliardsLandingPage(
            message: 'The You tube video for ${state.name} has been successfully added',
          ));
        }).onError((error, stackTrace) {
          c.completeError('Error AddYouTubeVideo ${state.name}');
          });
        break;
    }

    return c.future;
  }
}


class AddYouTubeState {
  String? name;

  String? videoId;
}
