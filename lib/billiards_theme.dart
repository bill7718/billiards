

import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

ThemeData getTheme() {
  const billiardsTheme = BilliardsTheme();
  return ThemeData(
    primarySwatch: billiardsTheme.primarySwatch,
    textTheme: TextTheme(
      bodyText2: TextStyle(fontSize: billiardsTheme.bodyFontSize, color: billiardsTheme.bodyContrast ) // default style for a Text widget
    ),
    errorColor: billiardsTheme.error,
    extensions:  [ const BilliardTextFieldTheme(width: 400), const BilliardsTheme(), BilliardFormTheme() ]


  );
}

@immutable
class BilliardsTheme extends ThemeExtension<BilliardsTheme> {

  final Color primary = const Color.fromRGBO(5, 5, 50, 1);
  final Color primaryContrast = Colors.white;
  final Color secondary = const Color.fromRGBO(150, 150, 150, 1);
  final Color secondaryContrast = Colors.white;
  final Color body = Colors.white;
  final Color bodyContrast = Colors.black;
  final Color error = Colors.red;

  final titleFontSize = 24.0;
  final subTitleFontSize = 18.0;
  final headingFontSize = 20.0;
  final subheadingFontSize = 16.0;
  final bodyFontSize = 14.0;
  final miniFontSize = 8.0;
  final blankLineHeight = 25.0;

  final double inputWidth = 200;

  MaterialColor get primarySwatch {
    return MaterialColor(primary.value,
        <int, Color>{
          50: primary,
          100: primary,
          200: primary,
          300: primary,
          400: primary,
          500: primary,
          600: primary,
          700: primary,
          800: primary,
          900: primary
        });
  }

  const BilliardsTheme();

  @override
  ThemeExtension<BilliardsTheme> copyWith()=>this;

  @override
  ThemeExtension<BilliardsTheme> lerp(ThemeExtension<BilliardsTheme>? other, double t) =>this;

}

class BilliardFormTheme extends ThemeExtension<BilliardFormTheme> {

  final EdgeInsets margin;

  BilliardFormTheme({this.margin = const EdgeInsets.all(15)});

  @override
  ThemeExtension<BilliardFormTheme> copyWith({EdgeInsets? newMargin}) {
    return BilliardFormTheme(margin: newMargin ?? const EdgeInsets.all(15));
  }

  @override
  ThemeExtension<BilliardFormTheme> lerp(ThemeExtension<BilliardFormTheme>? other, double t) {
    return this;
  }

}