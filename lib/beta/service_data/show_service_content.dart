import 'dart:math';

import 'package:billiards/beta/service_data/service_theme.dart';
import 'package:billiards/beta/service_data/text_part.dart';
import 'package:flutter/material.dart';

class ShowServiceContent extends StatelessWidget {
  final List<List<TextPart>> pages;
  final ServiceTheme theme;

  const ShowServiceContent(
      {super.key, required this.pages, required this.theme});

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    for (var page in pages) {
      widgets.add(FitSingleServiceContentPage(page: page, theme: theme));
    }

    return LayoutBuilder(builder: (_, constraints) {
      return SizedBox(
        width: constraints.maxWidth - 3,
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          children: widgets,
        ),
      );
    });
  }
}

///
/// Shows a single page of service content to the size specified by the theme allowing scrolling is necessary
///
class ShowSingleServiceContentPage extends StatelessWidget {
  final List<TextPart> page;
  final ServiceTheme theme;

  const ShowSingleServiceContentPage(
      {super.key, required this.page, required this.theme});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Container(
            color: theme.backgroundColor,
            padding: theme.padding,
            width: theme.width,
            height: theme.height,
            child: RichText(text: TextSpan(children: makeSpans(page, context, theme)))));
  }
}

///
/// Fits a single page of service content to the available size by scaling it
///
class FitSingleServiceContentPage extends StatelessWidget {
  final List<TextPart> page;
  final ServiceTheme theme;

  const FitSingleServiceContentPage(
      {super.key, required this.page, required this.theme});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      var scale = 1.0;
      scale = min(scale, constraints.maxWidth / theme.width);
      scale = min(scale, constraints.maxHeight / theme.height);
      final fitTheme = ServiceTheme.scale(scale, theme);


      return Center ( child: Container(
          color: fitTheme.backgroundColor,
          padding: fitTheme.padding,
          width: fitTheme.width,
          height: fitTheme.height,
          child: RichText(text: TextSpan(children: makeSpans(page, context, fitTheme)))));
    });
  }

}
