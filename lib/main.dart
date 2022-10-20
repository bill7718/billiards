library main;

import 'package:billiards/authenticate.dart';
import 'package:billiards/data.dart';
import 'package:billiards/pages.dart';
import 'package:billiards/src/services/current_time_provider.dart';

import 'package:flutter/material.dart';

import 'src/services/billiard_state.dart';
import 'billiards_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

var auth = AuthenticationService();
var data = FlutterFirebaseService();
var state = BilliardState();
var timeProvider = CurrentTimeProvider();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var f = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  f.then((value) {
    //checkFirestore();
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    // ignore: avoid_print
    print('Error caught by Flutter Error in main');
    FlutterError.presentError(details);
  };
  runApp(const BilliardsApp());
}

class BilliardsApp extends StatelessWidget {
  const BilliardsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>.value(value: auth),
          Provider<DataService>.value(value: data),
          Provider<BilliardState>.value(value: state),
          Provider<CurrentTimeProvider>.value(value: timeProvider)
        ],
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Worship',
        theme: getTheme(),
        home: const BilliardsWelcomePage(),
        ));
  }
}

void checkFirestore() async {
  //var smoke = await FirebaseFirestore.instance.doc('SmokeTest/test7718').get();
  //print(smoke.data());
  var i = await data.get('SmokeTest/test7718');
  print(i);

}
