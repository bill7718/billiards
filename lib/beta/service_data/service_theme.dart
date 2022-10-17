import 'package:flutter/material.dart';

class ServiceTheme {
  final double fontSize;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color fontColor;

  ServiceTheme(this.fontSize, this.width, this.height,
      this.backgroundColor, this.fontColor);

  EdgeInsets get padding => EdgeInsets.all(fontSize / 2);

  static ServiceTheme scale(double scale, ServiceTheme theme) {
    return ServiceTheme(theme.fontSize * scale, theme.width * scale,
        theme.height * scale, theme.backgroundColor, theme.fontColor);
  }
}