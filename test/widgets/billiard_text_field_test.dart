import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util.dart';
void main() {

  group ('Test BilliardTextField', ()  {
    group ('test initial display', ()
    {
      testWidgets(
          'Check that the field is shown correctly if there is just a label', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello', valueBinder: (v) {}, validator: (v)=>null,),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextFieldWithLabel = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                (widget.decoration as InputDecoration).labelText == 'Hello'));
        expect(fTextFieldWithLabel, findsOneWidget);

        var fTextFieldWithHelp = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                (widget.decoration as InputDecoration).helperText == ''));
        expect(fTextFieldWithHelp, findsOneWidget);
      });

      testWidgets(
          'Check that the field is shown correctly if help is provided', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello',help: 'Help Text', valueBinder: (v) {}, validator: (v)=>null),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextFieldWithLabel = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                (widget.decoration as InputDecoration).labelText == 'Hello'));
        expect(fTextFieldWithLabel, findsOneWidget);

        var fTextFieldWithHelp = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                (widget.decoration as InputDecoration).helperText == 'Help Text'));
        expect(fTextFieldWithHelp, findsOneWidget);
      });

      testWidgets(
          'Check that the field is shown correctly if hint is provided', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello',hint: 'Hint Text', valueBinder: (v) {}, validator: (v)=>null),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextFieldWithLabel = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                (widget.decoration as InputDecoration).labelText == 'Hello'));
        expect(fTextFieldWithLabel, findsOneWidget);

        var fTextFieldWithHint = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                (widget.decoration as InputDecoration).hintText == 'Hint Text'));
        expect(fTextFieldWithHint, findsOneWidget);
      });

      testWidgets(
          'Check the default values for read-only, maxLines, initialValue and obscure ', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello',valueBinder: (v) {}, validator: (v)=>null),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextField = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                widget.obscureText == false && widget.maxLines == 1 && widget.readOnly == false));
        expect(fTextField, findsOneWidget);

        var fTextFormField = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
        widget is TextFormField && widget.initialValue == ''));
        expect(fTextFormField, findsOneWidget);


      });

      testWidgets(
          'Check that the value for readOnly can be overridden ', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello', readOnly: true, valueBinder: (v) {}, validator: (v)=>null),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextField = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField && widget.readOnly == true));
        expect(fTextField, findsOneWidget);
      });

      testWidgets(
          'Check that the value for maxLines can be overridden ', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello', maxLines: 7, valueBinder: (v) {}, validator: (v)=>null),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextField = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField && widget.maxLines == 7));
        expect(fTextField, findsOneWidget);
      });

      testWidgets(
          'Check that the value for initialValue can be overridden ', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello', initialValue: 'hi', valueBinder: (v) {}, validator: (v)=>null),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextFormField = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextFormField && widget.initialValue == 'hi'));
        expect(fTextFormField, findsOneWidget);
      });

      testWidgets(
          'Check that the value for obscure can be overridden ', (
          WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello', obscure: true, valueBinder: (v) {}, validator: (v)=>null),
            ),
          ),
        );
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField),
            findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is BilliardTextField &&
            widget.label == 'Hello'), findsOneWidget);
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextField = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField && widget.obscureText == true));
        expect(fTextField, findsOneWidget);
      });
    });
    group ('test value binding', ()
    {
      testWidgets(
          'Check that when a field is entered it is bound to according to the valuebinder function provider', (
          WidgetTester tester) async {
            var value = '';
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: BilliardTextField(label: 'Hello',
              valueBinder: (v) {  value = v; },
              validator: (v)=>null),

            ),
          ),
        );
        var fBilliardTextField = find.byWidgetPredicate((
            widget) => widget is BilliardTextField);
        var fTextFieldWithLabel = find.descendant(of: fBilliardTextField,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField &&
                (widget.decoration as InputDecoration).labelText == 'Hello'));
        await tester.enterText(fTextFieldWithLabel, 'hi');
        await tester.pumpAndSettle();
        expect(value, 'hi');

      });
    });

    group ('test validation', ()
    {
      testWidgets(
          'Check that when a field is entered and it is invalid the widget reports an error', (
          WidgetTester tester) async {
        var value1 = '';
        var value2 = '';
        await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              body: Form (
                  child: Column( children: [
                BilliardTextField(label: 'Hello1',
                valueBinder: (v) {
                  value1 = v;
                  },
                validator: (v) {
                  if (v == 'invalid') {
                    return 'Invalid Value';
                  }
                  return null;
                },),

                BilliardTextField(label: 'Hello2',
                  valueBinder: (v) {  value2 = v; }, validator: (v)=>null),
              ]
            ))),
          ),
        );
        var fBilliardTextField1 = find.byWidgetPredicate((
            widget) => widget is BilliardTextField && widget.label == 'Hello1');
        await tester.enterText(fBilliardTextField1, 'invalid');
        await tester.pumpAndSettle();
        expect(value1, 'invalid');

        var fBilliardTextField1Error = find.descendant(of: fBilliardTextField1,
            matching: find.byWidgetPredicate((widget) =>
            widget is TextField && widget.decoration?.errorText == 'Invalid Value'));
        expect(fBilliardTextField1Error, findsNothing);

        var fBilliardTextField2 = find.byWidgetPredicate((
            widget) => widget is BilliardTextField && widget.label == 'Hello2');
        await tester.enterText(fBilliardTextField2, 'any');
        await tester.pumpAndSettle();
        expect(value2, 'any');
        expect(fBilliardTextField1Error, findsOneWidget);

      });
    });
  });


}