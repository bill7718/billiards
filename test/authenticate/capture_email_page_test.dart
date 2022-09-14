import 'package:billiards/src/authentication/capture_email_page.dart';
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
            home: CaptureEmailPage(
              handler: PageEventHandler<CaptureEmailOutputState>((o) {}),
              inputState: CaptureEmailInputState(null),
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
            widget.label == CaptureEmailPage.emailLabel);
        expect(textFieldPropertiesFinder, findsOneWidget);

        var buttonFinder =
            find.byWidgetPredicate((widget) => widget is TextButton);
        expect(buttonFinder, findsNWidgets(2));

        var buttonPropertiesFinder = find.ancestor(
            of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                widget.data == CaptureEmailPage.backButtonText),
            matching: find.byType(TextButton));
        expect(buttonPropertiesFinder, findsOneWidget);

        buttonPropertiesFinder = find.ancestor(
            of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                widget.data == CaptureEmailPage.nextButtonText),
            matching: find.byType(TextButton));
        expect(buttonPropertiesFinder, findsOneWidget);
      });

      testWidgets(
          'Check that initial display is correct where the email is provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: getTheme(),
            title: 'Test App',
            home: CaptureEmailPage(
              handler: PageEventHandler<CaptureEmailOutputState>((o) {}),
              inputState: CaptureEmailInputState('a@b.com'),
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
            widget.initialValue == 'a@b.com' &&
            widget.label == CaptureEmailPage.emailLabel);
        expect(textFieldPropertiesFinder, findsOneWidget);
      });

      testWidgets(
          'Check that initial display is correct where an error is provided',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: getTheme(),
            title: 'Test App',
            home:  CaptureEmailPage(
              handler: PageEventHandler<CaptureEmailOutputState>((o) {

              }),
              inputState: CaptureEmailInputState('a@b.com', error: 'Bad Thing'),
            )),
        );

        var errorFinder = find.byWidgetPredicate(
            (widget) => widget is ErrorMessage && widget.text == 'Bad Thing');
        expect(errorFinder, findsOneWidget);

        var textFieldFinder =
            find.byWidgetPredicate((widget) => widget is BilliardTextField);
        expect(textFieldFinder, findsOneWidget);

        var textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
            widget.initialValue == 'a@b.com' &&
            widget.label == CaptureEmailPage.emailLabel);
        expect(textFieldPropertiesFinder, findsOneWidget);
      });
    });

    group('test email field', () {
      testWidgets(
          'Check that an invalid email address reports an error',
              (WidgetTester tester) async {
            await tester.pumpWidget(
              MaterialApp(
                theme: getTheme(),
                title: 'Test App',
                home: CaptureEmailPage(
                      handler: PageEventHandler<CaptureEmailOutputState>((o) {
                        print ('next page');
                        return Container();
                      }),
                      inputState: CaptureEmailInputState(null),
                    )),

            );
            var textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == CaptureEmailPage.emailLabel);
            expect(textFieldPropertiesFinder, findsOneWidget);


            Finder nextButtonFinder = find.ancestor(
                of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                    widget.data == CaptureEmailPage.nextButtonText),
                matching: find.byType(TextButton));
            expect(nextButtonFinder, findsOneWidget);

            // this is needed to ensure that the focus moves off the text field when the next button is pressed
            await tester.pumpAndSettle(const Duration(milliseconds: 500));

            await tester.tap(nextButtonFinder);
            await tester.pump();

            var textFieldFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == CaptureEmailPage.emailLabel
            );
            expect(textFieldFinder, findsOneWidget);



            var textFieldErrorFinder = find.descendant(of: textFieldFinder, matching: find.byWidgetPredicate((widget) =>
                widget is TextField
                && (widget.decoration as InputDecoration).errorText == CaptureEmailPage.emailError
            ));
            expect(textFieldErrorFinder, findsOneWidget);



          });

      testWidgets(
          'Check that an valid email address does report not an error',
              (WidgetTester tester) async {
            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: CaptureEmailPage(
                    handler: PageEventHandler<CaptureEmailOutputState>((o) {}),
                    inputState: CaptureEmailInputState(null),
                  )),

            );
            var textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == CaptureEmailPage.emailLabel);
            expect(textFieldPropertiesFinder, findsOneWidget);

            await tester.enterText(textFieldPropertiesFinder, 'ba@gb.com');

            Finder nextButtonFinder = find.ancestor(
                of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                    widget.data == CaptureEmailPage.nextButtonText),
                matching: find.byType(TextButton));
            expect(nextButtonFinder, findsOneWidget);

            // this is needed to ensure that the focus moves off the text field when the next button is pressed
            await tester.pumpAndSettle(const Duration(milliseconds: 500));
            await tester.tap(nextButtonFinder);

            var textFieldFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == CaptureEmailPage.emailLabel
            );
            expect(textFieldFinder, findsOneWidget);



            var textFieldErrorFinder = find.descendant(of: textFieldFinder, matching: find.byWidgetPredicate((widget) =>
            widget is TextField
                      && (widget.decoration as InputDecoration).errorText == CaptureEmailPage.emailError
            ));
            expect(textFieldErrorFinder, findsNothing);

          });
    });

    group('test processing of button clicks', () {
      testWidgets(
          'Check that next on a valid screen goes to the next page',
              (WidgetTester tester) async {
            var button = '';
            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: CaptureEmailPage(
                    handler: PageEventHandler<CaptureEmailOutputState>((o) {
                      if (o.event == DefaultEvent.next) {
                        button = 'next';
                        return Container();
                      }
                    }),
                    inputState: CaptureEmailInputState(null),
                  )),

            );
            var textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == CaptureEmailPage.emailLabel);
            expect(textFieldPropertiesFinder, findsOneWidget);

            await tester.enterText(textFieldPropertiesFinder, 'ba@gb.com');

            Finder nextButtonFinder = find.ancestor(
                of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                    widget.data == CaptureEmailPage.nextButtonText),
                matching: find.byType(TextButton));
            expect(nextButtonFinder, findsOneWidget);

            await tester.tap(nextButtonFinder);
            expect(button, 'next');



          });

      testWidgets(
          'Check that back on an invalid screen goes back',
              (WidgetTester tester) async {
            var button = '';
            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: CaptureEmailPage(
                    handler: PageEventHandler<CaptureEmailOutputState>((o) {
                      if (o.event == DefaultEvent.back) {
                        button = 'back';
                        return Container();
                      }
                    }),
                    inputState: CaptureEmailInputState(null),
                  )),

            );


            Finder backButtonFinder = find.ancestor(
                of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                    widget.data == CaptureEmailPage.backButtonText),
                matching: find.byType(TextButton));
            expect(backButtonFinder, findsOneWidget);

            await tester.tap(backButtonFinder);
            expect(button, 'back');



          });

      testWidgets(
          'Check that home on an invalid screen goes home',
              (WidgetTester tester) async {
            var button = '';
            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: CaptureEmailPage(
                    handler: PageEventHandler<CaptureEmailOutputState>((o) {
                      if (o.event == DefaultEvent.home) {
                        button = 'home';
                        return Container();
                      }
                    }),
                    inputState: CaptureEmailInputState(null),
                  )),

            );
            await tapIcon(Icons.home,  tester);
            expect(button, 'home');
          });
    });
  });
}
