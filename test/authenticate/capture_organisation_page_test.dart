import 'package:billiards/authenticate.dart';
import 'package:billiards/beta/authenticate/capture_organisation_page.dart';
import 'package:billiards/billiards_theme.dart';
import 'package:billiards/journey.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util.dart';

void main() {
  group('Test Capture email page', () {
    group('test initial display', () {
      testWidgets('Check that initial display is correct for an empty input',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
              theme: getTheme(),
              title: 'Test App',
              home: CaptureOrganisationPage(
                handler:
                    PageEventHandler<CaptureOrganisationOutputState>((o) {}),
                inputState: CaptureOrganisationInputState(null),
              )),
        );

        var errorFinder = find.byWidgetPredicate(
            (widget) => widget is ErrorMessage && widget.text == null);
        expect(errorFinder, findsOneWidget);

        var textFieldFinder =
            find.byWidgetPredicate((widget) => widget is BilliardTextField);
        expect(textFieldFinder, findsOneWidget);

        var textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
            widget.initialValue == null &&
            widget.label == CaptureOrganisationPage.organisationLabel);
        expect(textFieldPropertiesFinder, findsOneWidget);

        var buttonFinder =
            find.byWidgetPredicate((widget) => widget is TextButton);
        expect(buttonFinder, findsNWidgets(2));

        var buttonPropertiesFinder = find.ancestor(
            of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                widget.data == CaptureOrganisationPage.backButtonText),
            matching: find.byType(TextButton));
        expect(buttonPropertiesFinder, findsOneWidget);

        buttonPropertiesFinder = find.ancestor(
            of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                widget.data == CaptureOrganisationPage.nextButtonText),
            matching: find.byType(TextButton));
        expect(buttonPropertiesFinder, findsOneWidget);
      });

      testWidgets(
          'Check that initial display is correct where the organisation is provided',
              (WidgetTester tester) async {
                await tester.pumpWidget(
                  MaterialApp(
                      theme: getTheme(),
                      title: 'Test App',
                      home: CaptureOrganisationPage(
                        handler:
                        PageEventHandler<CaptureOrganisationOutputState>((o) {}),
                        inputState: CaptureOrganisationInputState('Hello'),
                      )),
                );

                expect(checkError(null), true, reason: 'Error text of null not found');

            var textFieldFinder =
            find.byWidgetPredicate((widget) => widget is BilliardTextField);
            expect(textFieldFinder, findsOneWidget);

            var textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.initialValue == 'Hello' &&
                widget.label == CaptureOrganisationPage.organisationLabel);
            expect(textFieldPropertiesFinder, findsOneWidget);
          });
    });
  });
}
