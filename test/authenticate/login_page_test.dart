import 'package:billiards/src/authentication/login_page.dart';
import 'package:billiards/billiards_theme.dart';
import 'package:billiards/journey.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util.dart';

void main() {
  group('Test Login page', () {
    group('test initial display', () {
      testWidgets('Check that initial display is correct for an empty input',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: getTheme(),
            title: 'Test App',
            home: LoginPage(
              handler: PageEventHandler<LoginOutputState>((o) {}),
              inputState: LoginInputState(),
            )),
        );

        var errorFinder = find.byWidgetPredicate(
            (widget) => widget is ErrorMessage && widget.text == null);
        expect(errorFinder, findsOneWidget);

        var textFieldFinder =
            find.byWidgetPredicate((widget) => widget is BilliardTextField);
        expect(textFieldFinder, findsNWidgets(2));

        var emailFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
        widget is BilliardTextField &&
            widget.initialValue == null &&
            widget.label == LoginPage.emailLabel);
        expect(emailFieldPropertiesFinder, findsOneWidget);

        var passwordFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
        widget is BilliardTextField &&
            widget.initialValue == null &&
            widget.obscure == true &&
            widget.label == LoginPage.passwordLabel);
        expect(passwordFieldPropertiesFinder, findsOneWidget);

        var buttonFinder =
        find.byWidgetPredicate((widget) => widget is TextButton);
        expect(buttonFinder, findsNWidgets(2));

        var buttonPropertiesFinder = find.ancestor(
            of: find.byWidgetPredicate((widget) =>
            widget is Text &&
                widget.data == LoginPage.backButtonText),
            matching: find.byType(TextButton));
        expect(buttonPropertiesFinder, findsOneWidget);

        buttonPropertiesFinder = find.ancestor(
            of: find.byWidgetPredicate((widget) =>
            widget is Text &&
                widget.data == LoginPage.nextButtonText),
            matching: find.byType(TextButton));
        expect(buttonPropertiesFinder, findsOneWidget);

      });

      testWidgets(
          'Check that initial display is correct where the email/password is provided',
          (WidgetTester tester) async {

            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: LoginPage(
                    handler: PageEventHandler<LoginOutputState>((o) {}),
                    inputState: LoginInputState(email: 'a@b.com', password: 'password123'),
                  )),
            );

            var emailFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.initialValue == 'a@b.com' &&
                widget.label == LoginPage.emailLabel);
            expect(emailFieldPropertiesFinder, findsOneWidget);

            var passwordFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.initialValue == 'password123' &&
                widget.obscure == true &&
                widget.label == LoginPage.passwordLabel);
            expect(passwordFieldPropertiesFinder, findsOneWidget);
     });

      testWidgets(
          'Check that initial display is correct where an error is provided',
          (WidgetTester tester) async {

            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: LoginPage(
                    handler: PageEventHandler<LoginOutputState>((o) {}),
                    inputState: LoginInputState(error: 'Bad thing'),
                  )),
            );

            var errorFinder = find.byWidgetPredicate(
                    (widget) => widget is ErrorMessage && widget.text == 'Bad thing');
            expect(errorFinder, findsOneWidget);
      });
    });

    group('test data entry', () {
      testWidgets(
          'Check that an empty email address reports an error',
              (WidgetTester tester) async {
                await tester.pumpWidget(
                  MaterialApp(
                      theme: getTheme(),
                      title: 'Test App',
                      home: LoginPage(
                        handler: PageEventHandler<LoginOutputState>((o) {}),
                        inputState: LoginInputState(error: 'Bad thing'),
                      )),
                );

                Finder nextButtonFinder = find.ancestor(
                    of: find.byWidgetPredicate((widget) =>
                    widget is Text &&
                        widget.data == LoginPage.nextButtonText),
                    matching: find.byType(TextButton));
                expect(nextButtonFinder, findsOneWidget);

                await tester.tap(nextButtonFinder);
                await tester.pump();

                var textFieldFinder = find.byWidgetPredicate((widget) =>
                widget is BilliardTextField &&
                    widget.label == LoginPage.emailLabel
                );
                expect(textFieldFinder, findsOneWidget);

                var textFieldErrorFinder = find.descendant(of: textFieldFinder, matching: find.byWidgetPredicate((widget) =>
                widget is TextField
                    && (widget.decoration as InputDecoration).errorText == LoginPage.emailError
                ));
                expect(textFieldErrorFinder, findsOneWidget);
      });

      testWidgets(
          'Check that an empty password reports an error',
              (WidgetTester tester) async {
            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: LoginPage(
                    handler: PageEventHandler<LoginOutputState>((o) {}),
                    inputState: LoginInputState(),
                  )),
            );

            Finder nextButtonFinder = find.ancestor(
                of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                    widget.data == LoginPage.nextButtonText),
                matching: find.byType(TextButton));
            expect(nextButtonFinder, findsOneWidget);

            await tester.tap(nextButtonFinder);
            await tester.pump();

            var textFieldFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == LoginPage.passwordLabel
            );
            expect(textFieldFinder, findsOneWidget);

            var textFieldErrorFinder = find.descendant(of: textFieldFinder, matching: find.byWidgetPredicate((widget) =>
            widget is TextField
                && (widget.decoration as InputDecoration).errorText == LoginPage.passwordError
            ));
            expect(textFieldErrorFinder, findsOneWidget);
          });
    });

    group('test button presses', ()
    {

      LoginOutputState? output;
      setUp( () {
        output = null;
      });

      testWidgets(
          'Check that the back button calls handle function with the correct data',
              (WidgetTester tester) async {
            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: LoginPage(
                    handler: PageEventHandler<LoginOutputState>((LoginOutputState o)
                    {
                      output = o;
                      return Container();
                    }),
                    inputState: LoginInputState(),
                  )),
            );

            Finder backButtonFinder = find.ancestor(
                of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                    widget.data == LoginPage.backButtonText),
                matching: find.byType(TextButton));
            expect(backButtonFinder, findsOneWidget);

            await tester.tap(backButtonFinder);
            await tester.pump();

            expect(output?.event, DefaultEvent.back);
          });


      testWidgets(
          'Check that the next button calls handle function with the correct data',
              (WidgetTester tester) async {
            await tester.pumpWidget(
              MaterialApp(
                  theme: getTheme(),
                  title: 'Test App',
                  home: LoginPage(
                    handler: PageEventHandler<LoginOutputState>((LoginOutputState o)
                    {
                      output = o;
                      return Container();
                    }),
                    inputState: LoginInputState(),
                  )),
            );

            var textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == LoginPage.emailLabel);
            expect(textFieldPropertiesFinder, findsOneWidget);

            await tester.enterText(textFieldPropertiesFinder, 'ba@gb.com');

            textFieldPropertiesFinder = find.byWidgetPredicate((widget) =>
            widget is BilliardTextField &&
                widget.label == LoginPage.passwordLabel);
            expect(textFieldPropertiesFinder, findsOneWidget);

            await tester.enterText(textFieldPropertiesFinder, 'password123');

            Finder nextButtonFinder = find.ancestor(
                of: find.byWidgetPredicate((widget) =>
                widget is Text &&
                    widget.data == LoginPage.nextButtonText),
                matching: find.byType(TextButton));
            expect(nextButtonFinder, findsOneWidget);

            await tester.tap(nextButtonFinder);
            await tester.pump();

            expect(output?.event, DefaultEvent.next);
            expect(output?.email, 'ba@gb.com');
            expect(output?.password, 'password123');
          });
    });

    /*
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

     */
  });
}
