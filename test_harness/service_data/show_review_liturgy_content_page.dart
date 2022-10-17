import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/service_data.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:flutter/material.dart';



void main() {
  var content = '''
Hello
and hello again
**and bold**

this is a really really really really extremely long line designed to show how big the width is 

two lines missing
some texta text to make it go over one page
**bold** at the beginning
bold **in the** middle
bold at the **end**
not really **bold''';

  showPage(
    ReviewLiturgyContentPage(handler: PageEventHandler<ReviewLiturgyContentOutputState>(handleReviewLiturgyContent),
      inputState: ReviewLiturgyContentInputState('Hello@me.com','Prayers', content),)
  );
}

Future<Widget> handleReviewLiturgyContent(ReviewLiturgyContentOutputState output) async {
  return Card( child: Text(output.toString()));
}