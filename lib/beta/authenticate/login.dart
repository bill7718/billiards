import 'dart:async';
import 'package:billiards/authenticate.dart';
import 'package:billiards/data.dart';

import 'package:billiards/beta/services/organisation.dart';
import 'package:billiards/beta/services/billiard_state.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:billiards/pages.dart';
import 'package:flutter/material.dart';

class Login extends JourneyController {
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  handler: PageEventHandler<LoginOutputState>(handleLogin),
                  inputState: LoginInputState(),
                )));
  }

  Future<Widget> handleLogin(LoginOutputState pageOutputState) async {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case LoginEvent.back:
        c.complete(const BilliardsWelcomePage());
        break;

      case LoginEvent.next:
        state.email = pageOutputState.email;

        final users = await data.query(User.objectType, field: User.emailLabel, value: state.email);
        switch (users.length) {
          case 1:
            try {
              await auth.login(state.email ?? '', pageOutputState.password ?? '');

              coreState.user = User(data: users.first);
              coreState.user.setLoginDateTime(DateTime.now());
              coreState.user.set(User.loginFailureCountLabel, 0);
              await data.set(coreState.user.dbReference, coreState.user.data);
              final audit = Audit.fromValues(coreState.user.dbReference, 'Login');
              await data.set(audit.dbReference, audit.data);

              // see if there is just one linked organisation. If so then set that as well
              final organisationLinks = await DataObjectRelationship.list(data, coreState.user.id, User.userToOrganisation);
              switch (organisationLinks.length) {
                case 1:
                  final organisationData = await data
                      .get(PersistableDataObject.buildDBReference(Organisation.objectType, organisationLinks.first.toId ?? ''));
                  coreState.organisation = Organisation(data: organisationData);
                  c.complete(const BilliardsLandingPage());
                  break;

                default:
                  c.complete(const BilliardsLandingPage());
              }
            } catch (ex) {
              // the login has failed - probably because the password
              final u = User(data: users.first);
              u.set(User.loginFailureCountLabel, u.loginFailureCount + 1);
              c.complete(LoginPage(
                handler: PageEventHandler<LoginOutputState>(handleLogin),
                inputState: LoginInputState(
                    email: pageOutputState.email, password: pageOutputState.password, error: 'Login failed, please try again'),
              ));
            }
            break;

          default:
            c.completeError('Failed to login user ${state.email} could not find one matching user record.');
        }
    }
    return c.future;
  }
}

class LoginState {
  String? email;
}

//TODO save last login date/time
//TODO record failed login count
//TODO prevent reattempted login based on number of failed attempts
//TODO Audit failed login attempts - handle failed login attempt properly
//TODO Show last login date/time on Landing Page
