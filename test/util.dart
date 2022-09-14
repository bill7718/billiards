

import 'dart:async';

import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

bool checkIconButton(IconData iconData, { String? tooltip }) {
  try {
    Finder fIconButton = find.byWidgetPredicate((widget) => widget is IconButton && widget.icon is Icon && (widget.icon as Icon).icon == iconData);
    expect(fIconButton, findsOneWidget);
    if (tooltip != null) {
      Finder fWithToolTip = find.byWidgetPredicate((widget) => widget is IconButton && widget.tooltip == tooltip && widget.icon is Icon && (widget.icon as Icon).icon == iconData);
      expect(fWithToolTip, findsOneWidget);
    }

    return true;
  } catch (ex) {
    return false;
  }
}

Future<void> tapIcon(IconData icon, WidgetTester tester) async {
  var c = Completer<void>();
  Finder fIconButton = find.byWidgetPredicate((widget) => widget is IconButton && (widget.icon as Icon).icon == icon);
  expect(fIconButton, findsOneWidget);
  await tester.tap(fIconButton);
  c.complete();
  return c.future;
}

bool checkError(String? errorText) {
  try {
    var errorFinder = find.byWidgetPredicate(
            (widget) => widget is ErrorMessage && widget.text == errorText);
    expect(errorFinder, findsOneWidget);
    return true;
  } catch (ex) {
    return false;
  }
}