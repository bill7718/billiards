import 'package:billiards/beta/service_data/service_theme.dart';
import 'package:flutter/material.dart';

class TextPart {
  final String text;
  final bool bold;

  TextPart(this.text, {this.bold = false});

  static List<TextPart> parse(String text) {
    var response = <TextPart>[];
    var firstLine = true;
    for (var line in text.split('\n')) {
      if (!firstLine) {
        if (line.isEmpty) {
          response.add(TextPart('\n#'));
        } else {
          response.add(TextPart('\n'));
        }

      } else {
        firstLine = false;
      }

      var bold = false;
      for (var item in line.split('**')) {
        if (item.isNotEmpty) {
          if (bold) {
            response.add(TextPart(item, bold: true));
          } else {
            response.add(TextPart(item));
          }
        }
        bold = !bold;
      }
    }

    return response;
  }
}


List<TextSpan> makeSpans(final List<TextPart> parts, final BuildContext context, final ServiceTheme serviceTheme) {


  final boldStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: serviceTheme.fontSize,
      color: serviceTheme.fontColor);

  final normalStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
      fontSize: serviceTheme.fontSize,
      color: serviceTheme.fontColor);

  final hiddenStyle = Theme.of(context).textTheme.bodyText2?.copyWith(
      fontSize: serviceTheme.fontSize,
      color: serviceTheme.backgroundColor);


  var response = <TextSpan>[];
  for (var part in parts) {
    if (part.bold) {
      response.add(TextSpan(text: part.text, style: boldStyle));
    } else {
      if (part.text == '\n#') {
        response.add(TextSpan(text: part.text, style: hiddenStyle));
      } else {
        response.add(TextSpan(text: part.text, style: normalStyle));
      }

    }
  }

  return response;
}
