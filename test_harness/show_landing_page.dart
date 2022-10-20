
import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/pages.dart';
import 'package:flutter/material.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();


  FlutterError.onError = (FlutterErrorDetails details) {
    // ignore: avoid_print
    print('Error caught by Flutter Error in main');
    FlutterError.presentError(details);
  };
  runApp(const TestApp(page: BilliardsLandingPage()));
}

