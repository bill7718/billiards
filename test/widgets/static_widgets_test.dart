import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../util.dart';
void main() {

  group ('Test UnauthenticatedOutJourneyAppBar', ()  {
    testWidgets('Check that the appbar is shown', (WidgetTester tester) async {
      await tester.pumpWidget(
          MaterialApp(
            title: 'Worship',
            home: Scaffold(
              appBar: UnauthenticatedOutJourneyAppBar(title: 'Hello')),
            ),
          );
      expect (find.byType(Text), findsOneWidget );
      expect (find.text('Hello'), findsOneWidget );
    });
  });

  group ('Test UnauthenticatedInJourneyAppBar', ()  {
    testWidgets('Check that the appbar is shown and that the home icon can be tapped', (WidgetTester tester) async {
      var homeCount = 0;
      await tester.pumpWidget(
        MaterialApp(
          title: 'Worship',
          home: Scaffold(
              appBar: UnauthenticatedInJourneyAppBar(title: 'Hello', home: ()
              {
               homeCount++;
              } )),
        ),
      );
      expect (find.byType(Text), findsOneWidget );
      expect (find.text('Hello'), findsOneWidget );
      expect (checkIconButton(Icons.home), true );

      await tapIcon(Icons.home,  tester);
      expect(homeCount, 1);

    });
  });

  group ('Test AuthenticatedOutJourneyAppBar', ()  {
    testWidgets('Check that the appbar is shown', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          title: 'Worship',
          home: Scaffold(
              appBar: AuthenticatedOutJourneyAppBar(title: 'Hello', email: 'a@b.com')),
        ),
      );
      expect (find.byType(Text), findsOneWidget );
      expect (find.text('Hello'), findsOneWidget );
      expect (checkIconButton(Icons.person, tooltip: 'a@b.com'), true );
    });
  });

  group ('Test AuthenticatedInJourneyAppBar', ()  {
    testWidgets('Check that the appbar is shown and that the home icon can be tapped', (WidgetTester tester) async {
      var homeCount = 0;
      await tester.pumpWidget(
        MaterialApp(
          title: 'Worship',
          home: Scaffold(
              appBar: AuthenticatedInJourneyAppBar(title: 'Hello', email: 'a@b.com', home: ()
              {
                homeCount++;
              } )),
        ),
      );
      expect (find.byType(Text), findsOneWidget );
      expect (find.text('Hello'), findsOneWidget );
      expect (checkIconButton(Icons.home), true );

      await tapIcon(Icons.home,  tester);
      expect(homeCount, 1);

      expect (checkIconButton(Icons.person, tooltip: 'a@b.com'), true );

    });
  });

  group ('Test ErrorMessage', ()  {
    testWidgets('Check that the error message is shown correctly if the text is provided', (WidgetTester tester) async {
      await tester.pumpWidget(
         MaterialApp(
          title: 'Worship',
          theme: ThemeData(
            errorColor: Colors.amber,
              textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 21 )
          )),
          home: const Scaffold(
            body: ErrorMessage(text: 'Error'),
              ),
        ),
      );

      Finder f = find.byWidgetPredicate((widget) => widget is Text && widget.data == 'Error' && widget.style?.fontSize == 21 && widget.style?.color == Colors.amber);
      expect(f, findsOneWidget);

    });

    testWidgets('Check that the error message is shown correctly if the text is not provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          title: 'Worship',
          theme: ThemeData(
              errorColor: Colors.amber,
              textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 21 )
              )),
          home: const Scaffold(
            body: ErrorMessage(),
          ),
        ),
      );

      Finder f = find.byWidgetPredicate((widget) => widget is Text && widget.data == '' && widget.style?.fontSize == 21 && widget.style?.color == Colors.amber);
      expect(f, findsOneWidget);

    });
  });

  group ('Test BodyText', ()
  {
    testWidgets(
        'Check that the text is shown correctly ', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          title: 'Worship',
          theme: ThemeData(
              textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 22)
              )),
          home: const Scaffold(
            body: BodyText(text: 'Hello'),
          ),
        ),
      );

      Finder f = find.byWidgetPredicate((widget) =>
      widget is Text && widget.data == 'Hello' &&
          widget.style?.fontSize == 22);
      expect(f, findsOneWidget);
    });
  });

  group ('Test Heading', ()
  {
    testWidgets(
        'Check that the text is shown correctly ', (
        WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          title: 'Worship',
          theme: ThemeData(
              textTheme: const TextTheme(headline5: TextStyle(fontSize: 28)
              )),
          home: const Scaffold(
            body: Heading(text: 'Hello Heading'),
          ),
        ),
      );

      Finder f = find.byWidgetPredicate((widget) =>
      widget is Text && widget.data == 'Hello Heading' &&
          widget.style?.fontSize == 28);
      expect(f, findsOneWidget);
    });
  });
}