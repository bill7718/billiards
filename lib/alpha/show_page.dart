import 'package:billiards/billiards_theme.dart';
import 'package:flutter/material.dart';

void showPage(Widget page) async {
  WidgetsFlutterBinding.ensureInitialized();


  FlutterError.onError = (FlutterErrorDetails details) {
    // ignore: avoid_print
    print('Error caught by Flutter Error in main');
    FlutterError.presentError(details);
  };
  runApp(TestApp(page: page));
}

class TestApp extends StatelessWidget {
  final Widget page;

  const TestApp({Key? key, required this.page}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Worship',
            theme: getTheme(),
            home: Container(child: page),
            );
  }
}


