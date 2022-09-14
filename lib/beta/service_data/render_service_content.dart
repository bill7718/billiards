import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplitServiceContent extends StatefulWidget {
  final String content;
  final RenderServiceTheme displayTheme;
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
  late List<TextSpan>? remainingSpans;
  late List<TextSpan> currentSpans;

  List<List<TextSpan>> pages = <List<TextSpan>>[];

  @override
  void initState() {
    super.initState();
    currentSpans = <TextSpan>[];
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();

    final boldStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: widget.displayTheme.fontSize,
        color: widget.displayTheme.fontColor);

    final normalStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
        fontSize: widget.displayTheme.fontSize,
        color: widget.displayTheme.fontColor);

    remainingSpans ??= parse(widget.content, normalStyle, boldStyle);
    currentSpans.addAll(remainingSpans ?? <TextSpan>[]);

    return RenderServiceContent(
      key: key,
      spans: currentSpans,
      displayTheme: widget.displayTheme,
      sizeCallback: (s) {
        if (s.height > widget.displayTheme.height) {
          setState(() {
            currentSpans.removeLast();
          });
        } else {
          pages.add(currentSpans);
          remainingSpans?.removeRange(0, currentSpans.length);
          currentSpans.clear();
          currentSpans.addAll(remainingSpans ?? <TextSpan>[]);
          if (currentSpans.isNotEmpty) {
            setState(() {

            });
          } else {
            widget.callback(pages);
          }
        }
      },
    );
  }

  List<TextSpan> parse(
      String text, TextStyle? normalStyle, TextStyle? boldStyle) {
    var response = <TextSpan>[];
    var firstLine = true;
    for (var line in text.split('\n')) {
      if (!firstLine) {
        response.add(const TextSpan(text: '\n'));
      } else {
        firstLine = false;
      }

      var bold = false;
      for (var item in line.split('**')) {
        if (item.isNotEmpty) {
          if (bold) {
            response.add(TextSpan(text: item, style: boldStyle));
          } else {
            response.add(TextSpan(text: item, style: normalStyle));
          }
        }
        bold = !bold;
      }
    }

    return response;
  }
}



class RenderServiceContent extends StatelessWidget {
  static void dummyCallback(Size s) {}

  final List<TextSpan> spans;
  final RenderServiceTheme displayTheme;
  final Function sizeCallback;

  const RenderServiceContent(
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
            padding: EdgeInsets.all(displayTheme.fontSize / 2),
            width: displayTheme.width,
            child: RichText(text: TextSpan(children: spans))));
  }
}

class RenderServiceTheme {
  final double fontSize;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color fontColor;

  RenderServiceTheme(this.fontSize, this.width, this.height,
      this.backgroundColor, this.fontColor);
}
