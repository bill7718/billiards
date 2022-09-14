import 'package:billiards/service_data.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:flutter/material.dart';

import '../../lib/alpha/show_page.dart';


void main() {


  showPage(
    ReviewLiturgyContentPage(handler: PageEventHandler<ReviewLiturgyContentOutputState>(handleReviewLiturgyContent),
      inputState: ReviewLiturgyContentInputState('Hello@me.com','Prayers', 'Dear God'),)
  );
}

Future<Widget> handleReviewLiturgyContent(CaptureLiturgyContentOutputState output) async {
  return Card( child: Text(output.toString()));
}