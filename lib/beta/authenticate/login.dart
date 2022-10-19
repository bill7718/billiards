import 'dart:async';
import 'package:billiards/authenticate.dart';
import 'package:billiards/data.dart';

import 'package:billiards/beta/services/organisation.dart';
import 'package:billiards/beta/services/billiard_state.dart';


import 'package:billiards/src/journey/journey_controller.dart';

import 'package:billiards/pages.dart';
import 'package:flutter/material.dart';




class Login  extends JourneyController {

  final AuthenticationService auth;
  final DataService data;
  final BilliardState coreState;

  final LoginState state = LoginState();

  Login(this.auth, this.data, this.coreState);

  @override
  void start(BuildContext context) {
    showLogin(context);
  }

  void showLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>
        LoginPage(
            handler: PageEventHandler<LoginOutputState>(handleLogin), inputState: LoginInputState(),)) );
  }

  Future<Widget> handleLogin(LoginOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case LoginEvent.back :
        c.complete(const BilliardsWelcomePage());
        break;

      case LoginEvent.next :
        state.email = pageOutputState.email;
        var fUser = auth.login(state.email ?? '' , pageOutputState.password ?? '');
        fUser.then((value) {
          var fUsers = data.query(User.objectType, field: User.emailLabel, value: state.email);
          fUsers.then( (list) {
            if (list.isEmpty || list.length > 1) {
              c.completeError('User: ${state.email} does not have a single user');
            } else {
              coreState.user = User(data: list.first);
              coreState.user.setLoginDateTime(DateTime.now());
              coreState.user.set(User.loginFailureCountLabel, 0);
              data.set(coreState.user.dbReference, coreState.user.data);
              // see if there is just one linked organisation. If so then set that as well
              var fRel = DataObjectRelationship.list(data, coreState.user.id, User.userToOrganisation);
              fRel.then( (list) {
                var audit = Audit.fromValues(coreState.user.dbReference, 'Login');
                data.set(audit.dbReference, audit.data);
                if (list.length == 1) {
                  var fOrg = data.get(PersistableDataObject.buildDBReference(Organisation.objectType, list.first.toId ?? ''));
                  fOrg.then( (map) {
                    coreState.organisation = Organisation(data: map);
                    c.complete(const BilliardsLandingPage());
                  });
                } else {

                  c.complete(const BilliardsLandingPage());
                }
              });

            }

          });

        }).onError((error, stackTrace) {
          c.completeError(error ?? 'Failed to login user ${state.email}');
        });
        break;
    }
    return c.future;
  }




}

class LoginState  {

  String? email;

}

//TODO save last login date/time
//TODO record failed login count
//TODO prevent reattempted login based on number of failed attempts
//TODO Audit failed login attempts - handle failed login attempt properly
//TODO Show last login date/time on Landing Page


