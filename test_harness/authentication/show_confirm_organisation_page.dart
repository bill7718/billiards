import 'package:billiards/authenticate.dart';
import 'package:billiards/src/journey/journey_controller.dart';

import 'package:flutter/material.dart';

import '../../lib/alpha/show_page.dart';


void main() {


  showPage(
    ConfirmOrganisationPage(handler: PageEventHandler<ConfirmOrganisationOutputState>(handleConfirmOrganisation),
      inputState: ConfirmOrganisationInputState('Curveball'),)
  );
}

Future<Widget> handleConfirmOrganisation(ConfirmOrganisationOutputState output) async {
  return Card( child: Text(output.toString()));
}