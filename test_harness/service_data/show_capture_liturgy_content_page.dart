import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/service_data.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:flutter/material.dart';



void main() {


  showPage(
    CaptureLiturgyContentPage(handler: PageEventHandler<CaptureLiturgyContentOutputState>(handleCaptureLiturgyContent),
      inputState: CaptureLiturgyContentInputState('Hello@me.com','Prayers'),)
  );
}

Future<Widget> handleCaptureLiturgyContent(CaptureLiturgyContentOutputState output) async {
  return Card( child: Text(output.toString()));
}