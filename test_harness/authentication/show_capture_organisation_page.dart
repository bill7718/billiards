import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/authenticate.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:flutter/material.dart';



void main() {


  showPage(
    CaptureOrganisationPage(handler: PageEventHandler<CaptureOrganisationOutputState>(handleCaptureOrganisation),
      inputState: CaptureOrganisationInputState('Hello', error: 'This organisation name is already in use'),)
  );
}

Future<Widget> handleCaptureOrganisation(CaptureOrganisationOutputState output) async {
  return Card( child: Text(output.toString()));
}