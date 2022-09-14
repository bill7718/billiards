import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/service_data.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:flutter/material.dart';




void main() {


  showPage(
    CaptureLiturgyNamePage(handler: PageEventHandler<CaptureLiturgyNameOutputState>(handleCaptureLiturgyName),
      inputState: CaptureLiturgyNameInputState('Hello', error: 'This  name is already in use'),)
  );
}

Future<Widget> handleCaptureLiturgyName(CaptureLiturgyNameOutputState output) async {
  return Card( child: Text(output.toString()));
}