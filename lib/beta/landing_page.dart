
import 'dart:async';

import 'package:billiards/authenticate.dart';
import 'package:billiards/src/services/billiard_state.dart';
import 'package:billiards/data.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authenticate/invite_user.dart';



class BilliardsLandingPage extends StatelessWidget {

  static const String lightWaveText = '''
Lightwave allows you create and display liturgy for your church. 
  ''';

  final String? message;

  const BilliardsLandingPage({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (message!= null) {
      var t = Timer(const Duration(milliseconds: 250), () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message ?? ''),
          duration: const Duration(seconds: 3),
        ));


      });
    }

    return Scaffold(
      appBar: AuthenticatedOutJourneyAppBar(title: 'Welcome to Lightwave', email: 'a@b.com',),

      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(height: 40, child: DrawerHeader(padding: EdgeInsets.zero, margin: EdgeInsets.zero,child: Heading(text: 'Header'),)),
            ListTile(title: const Text('Invite New User'), onTap: (){
              final j = InviteUser(Provider.of<DataService>(context, listen: false), Provider.of<BilliardState>(context, listen: false));
              j.start(context);
            },),
          ],
        )
      ),
      body: Container (
          margin: const EdgeInsets.all(25),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Center ( child: Heading(text: 'Welcome to Lightwave')),
          FormRow(content: BodyText(text: lightWaveText),)




        ],

      )),
    );
  }
}
