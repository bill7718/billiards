import 'package:billiards/authenticate.dart';
import 'package:billiards/data.dart';

import 'package:billiards/src/services/billiard_state.dart';
import 'package:billiards/src/services/current_time_provider.dart';

import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/login.dart';
import '../../beta/authenticate/register_user.dart';

///
/// The page that welcomes a new user
///
/// It provides options to register as a new user or to log in
///
class BilliardsWelcomePage extends StatelessWidget {
  static const String lightWaveText = '''
  Lightwave allows you create and display liturgy for your church. 
  ''';

  const BilliardsWelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UnauthenticatedOutJourneyAppBar(title: 'Welcome to Lightwave'),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Heading(text: 'Welcome to Lightwave')),
              Row(
                children: [
                  Expanded(child: Container()),
                  const Expanded(
                    flex: 5,
                    child: BodyText(text: lightWaveText),
                  ),
                  Expanded(child: Container())
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text('Register as a new User'),
                    onPressed: () {
                      final j = RegisterUser(Provider.of<AuthenticationService>(context, listen: false),
                          Provider.of<DataService>(context, listen: false), Provider.of<BilliardState>(context, listen: false));
                      j.startHandler.handleEvent(Navigator.of(context), null);
                    },
                  ),
                  TextButton(
                    child: const Text('Login'),
                    onPressed: () {
                      final j = Login(
                          Provider.of<AuthenticationService>(context, listen: false),
                          Provider.of<DataService>(context, listen: false),
                          Provider.of<BilliardState>(context, listen: false),
                          Provider.of<CurrentTimeProvider>(context, listen: false));
                      j.startHandler.handleEvent(Navigator.of(context), null);
                    },
                  )
                ],
              )
            ],
          )),
    );
  }
}
