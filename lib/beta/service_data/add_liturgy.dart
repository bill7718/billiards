import 'dart:async';
import 'package:billiards/data.dart';

import 'package:billiards/src/services/billiard_state.dart';
import 'package:billiards/src/journey/journey_controller.dart';

import 'package:billiards/pages.dart';
import 'package:billiards/service_data.dart';
import 'package:flutter/material.dart';


class AddLiturgy extends JourneyController {
  final DataService data;
  final BilliardState coreState;

  final AddLiturgyState state = AddLiturgyState();

  AddLiturgy(this.data, this.coreState);

  @override
  void start(BuildContext context) {
    showCaptureName(context);
  }

  void showCaptureName(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CaptureLiturgyNamePage(
                  handler:
                      PageEventHandler<CaptureLiturgyNameOutputState>(handleCaptureName),
                  inputState: CaptureLiturgyNameInputState(
                      coreState.user.email ),
                )));
  }

  Future<Widget> handleCaptureName(CaptureLiturgyNameOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.next:
        state.name = pageOutputState.name;
        c.complete(CaptureLiturgyContentPage(inputState: CaptureLiturgyContentInputState(coreState.user.email, state.name ?? ''),
            handler: PageEventHandler<CaptureLiturgyContentOutputState>(handleCaptureContent)));
    }

    return c.future;
  }

  Future<Widget> handleCaptureContent(CaptureLiturgyContentOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(CaptureLiturgyNamePage(
          handler:
          PageEventHandler<CaptureLiturgyNameOutputState>(handleCaptureName),
          inputState: CaptureLiturgyNameInputState(
              coreState.user.email, name: state.name ),
        ));
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.next:
        state.name = pageOutputState.text;
        c.complete(ReviewLiturgyContentPage(inputState: ReviewLiturgyContentInputState(coreState.user.email, state.name ?? '', state.text ?? ''),
            handler: PageEventHandler<ReviewLiturgyContentOutputState>(handleReviewContent),));
    }

    return c.future;
  }

  Future<Widget> handleReviewContent(ReviewLiturgyContentOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(CaptureLiturgyContentPage(
          handler:
          PageEventHandler<CaptureLiturgyContentOutputState>(handleCaptureContent),
          inputState: CaptureLiturgyContentInputState(
              coreState.user.email, state.name ?? '', text: state.text ),
        ));
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.next:
        var liturgy = Liturgy.fromValues(coreState.organisation!.dbReference, state.name!, state.text!);
        var f = data.set(liturgy.dbReference, liturgy.data);
        f.then ( (_) {
          c.complete(BilliardsLandingPage(message: 'The Liturgy for ${state.name} has been successfully added',));
        }).onError((error, stackTrace) {
          c.completeError(error ?? 'Error adding ${state.name}');
        });
        break;

    }

    return c.future;
  }


}

class AddLiturgyState {
  String? name;

  String? text;
}
