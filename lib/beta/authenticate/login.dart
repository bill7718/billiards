import 'dart:async';
import 'package:billiards/authenticate.dart';
import 'package:billiards/data.dart';

import 'package:billiards/beta/services/organisation.dart';
import 'package:billiards/src/services/billiard_state.dart';

import 'package:billiards/src/journey/journey_controller.dart';

import 'package:billiards/pages.dart';
import 'package:flutter/material.dart';

///
/// Controls the Login Journey
///
class Login extends JourneyController {

  /// Service that authenticates the user
  final AuthenticationService auth;

  /// Manages database access
  final DataService data;

  /// The main application state. Holds state that is common to many journeys
  final BilliardState coreState;

  /// State for this journey
  final LoginState state = LoginState();

  Login(this.auth, this.data, this.coreState);

  /// Shows the login page
  @override
  void start(BuildContext context) {
    _showLogin(context);
  }

  /// Display the login page with default values
  void _showLogin(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  handler: PageEventHandler<LoginOutputState>(handleLogin),
                  inputState: LoginInputState(),
                )));
  }

  /// Handles the response from the login page
  Future<Widget> handleLogin(LoginOutputState pageOutputState) async {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(const BilliardsWelcomePage());
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsWelcomePage());
        break;

      case DefaultEvent.next:
        state.email = pageOutputState.email;

        final users = await data.query(User.objectType, field: User.emailLabel, value: state.email);
        switch (users.length) {
          case 1:
            try {
              await auth.login(state.email ?? '', pageOutputState.password ?? '');

              coreState.user = User(data: users.first);
              coreState.user.setLoginDateTime(DateTime.now());
              coreState.user.setDateTime(User.lastFailedLoginLabel, null);
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
              final userData = User(data: users.first);
              userData.set(User.loginFailureCountLabel, userData.loginFailureCount + 1);
              userData.setDateTime(User.lastFailedLoginLabel, DateTime.now());
              data.set(userData.dbReference, userData.data);
              final audit = Audit.fromValues(coreState.user.dbReference, 'Failed Login');
              data.set(audit.dbReference, audit.data);
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

//TODO prevent reattempted login based on number of failed attempts
//TODO Show last login date/time on Landing Page
