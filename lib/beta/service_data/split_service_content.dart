import 'dart:math';

import 'package:billiards/beta/service_data/service_theme.dart';
import 'package:billiards/beta/service_data/text_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplitServiceContent extends StatefulWidget {
  final String content;
  final ServiceTheme displayTheme;
  final Function callback;

  const SplitServiceContent(
      {Key? key,
      required this.content,
      required this.displayTheme,
      required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => SplitServiceContentState();
}

class SplitServiceContentState extends State<SplitServiceContent> {

  late List<TextPart> allParts;

  late List<TextPart> remainingParts;
  late List<TextPart> currentParts;

  List<List<TextPart>> pages = <List<TextPart>>[];


  @override
  void initState() {
    super.initState();
    allParts = TextPart.parse(widget.content);
    remainingParts = TextPart.parse(widget.content);
    currentParts = TextPart.parse(widget.content);
  }

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(builder: (context, constraints ) {

      final key = GlobalKey();

      var scale = 1.0;
      scale = min(scale, constraints.maxWidth / widget.displayTheme.width);
      scale = min(scale, constraints.maxHeight / widget.displayTheme.height);
      final fitTheme = ServiceTheme.scale(scale, widget.displayTheme);

      return _MeasureServiceContent(
        key: key,
        spans: makeSpans(currentParts, context, fitTheme),
        displayTheme: fitTheme,
        sizeCallback: (s) {
          if (s.height > fitTheme.height) {
            setState(() {
              currentParts.removeLast();
            });
          } else {
            var content = <TextPart>[];
            content.addAll(currentParts);
            pages.add(content);
            remainingParts.removeRange(0, currentParts.length);
            bool firstIsEmpty = true;
            while (remainingParts.isNotEmpty && firstIsEmpty) {
              if (remainingParts.first.text == '\n') {
                remainingParts.removeAt(0);
              } else {
                firstIsEmpty = false;
              }
            }
            currentParts.clear();
            currentParts.addAll(remainingParts);

            if (currentParts.isNotEmpty) {
              setState(() {});
            } else {
              widget.callback(pages);
            }
          }
        },
      );
    });


  }
}

class _MeasureServiceContent extends StatelessWidget {
  static void dummyCallback(Size s) {}

  final List<TextSpan> spans;
  final ServiceTheme displayTheme;
  final Function sizeCallback;

  const _MeasureServiceContent(
      {Key? key,
      required this.spans,
      required this.displayTheme,
      this.sizeCallback(Size s) = dummyCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      sizeCallback(key.currentContext?.size);
    });

    return SingleChildScrollView(
        child: Container(
            key: key,
            color: displayTheme.backgroundColor,
            padding: displayTheme.padding,
            width: displayTheme.width,
            child: RichText(text: TextSpan(children: spans))));
  }
}
