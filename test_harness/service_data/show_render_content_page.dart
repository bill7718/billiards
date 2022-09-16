import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/beta/service_data/render_service_content.dart';
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
**bold** at the beginning
bold **in the** middle
bold at the **end**
not really **bold''';
  showPage(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Container()),
        SplitServiceContent(
            content: content,
            displayTheme:
                RenderServiceTheme(60, 1600, 600, Colors.black, Colors.white),
        callback: (pages) {
              for (var spans in pages) {
                print('spans: ${spans.length}');
              }

        },),
        Expanded(child: Container()),
      ]));
}
