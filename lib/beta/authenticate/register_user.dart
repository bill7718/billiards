import 'dart:async';
import 'package:billiards/authenticate.dart';
import 'package:billiards/data.dart';
import 'package:billiards/src/authentication/capture_email_page.dart';

import 'package:billiards/src/services/billiard_state.dart';
import 'package:billiards/pages.dart';
import 'package:flutter/material.dart';

import '../../src/journey/journey_controller.dart';
import '../../src/data/data_object_relationship.dart';
import '../../src/data/data_service.dart';
import '../../src/services/organisation.dart';
import '../../src/pages/landing_page.dart';
import '../../src/pages/welcome_page.dart';
import 'capture_organisation_page.dart';
import 'capture_password_page.dart';

class RegisterUser extends JourneyController {
  final AuthenticationService auth;
  final DataService data;
  final BilliardState coreState;

  final RegisterUserState state = RegisterUserState();

  RegisterUser(this.auth, this.data, this.coreState);

  @override
  void start(BuildContext context) {
    showCaptureEmail(context);
  }

  void showCaptureEmail(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CaptureEmailPage(
                inputState: CaptureEmailInputState(null),
                handler: PageEventHandler<CaptureEmailOutputState>(
                    handleCaptureEmail))));
  }

  Future<Widget> handleCaptureEmail(CaptureEmailOutputState pageOutputState) {
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
        var fUser = findUserByEmail(state.email ?? '');
        fUser.then((user) {
          if (user == null) {
            c.complete(CapturePasswordPage(
                inputState: state,
                handler: PageEventHandler<CapturePasswordOutputState>(
                    handleCapturePassword)));
          } else {
            c.complete(CaptureEmailPage(
                inputState: CaptureEmailInputState(state.email,
                    error: 'This email address is already in use'),
                handler: PageEventHandler<CaptureEmailOutputState>(
                    handleCaptureEmail)));
          }
        });

        break;
    }
    return c.future;
  }

  Future<Widget> handleCapturePassword(
      CapturePasswordOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(CaptureEmailPage(
            inputState: CaptureEmailInputState(state.email),
            handler:
                PageEventHandler<CaptureEmailOutputState>(handleCaptureEmail)));
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsWelcomePage());
        break;

      case DefaultEvent.next:
        state.password = pageOutputState.password;
        c.complete(CaptureOrganisationPage(
            inputState: CaptureOrganisationInputState(null),
            handler: PageEventHandler<CaptureOrganisationOutputState>(
                handleCaptureOrganisation)));
        break;
    }
    return c.future;
  }

  Future<Widget> handleCaptureOrganisation(
      CaptureOrganisationOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(CapturePasswordPage(
            inputState: state,
            handler: PageEventHandler<CapturePasswordOutputState>(
                handleCapturePassword)));
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsWelcomePage());
        break;

      case DefaultEvent.next:
        state.organisation = pageOutputState.organisation;
        var fOrg = findOrganisationByName(state.organisation ?? '');
        fOrg.then((org) {
          if (org == null) {
            var f = createUser();
            f.then((user) {
              Organisation o = Organisation();
              o.name = state.organisation;
              var fOrg = data.set(o.dbReference, o.data);
              fOrg.then((_) {
                var rel = DataObjectRelationship.data(
                    from: user, to: o, type: User.userToOrganisation);
                var fRel = data.set(rel.dbReference, rel.data);
                fRel.then((_) {
                  coreState.user = user;
                  coreState.organisation = o;
                  c.complete(const BilliardsLandingPage());
                });
              });
            });
          } else {
            c.complete(CaptureOrganisationPage(
                inputState: CaptureOrganisationInputState(
                    pageOutputState.organisation,
                    error: 'This organisation is already in use'),
                handler: PageEventHandler<CaptureOrganisationOutputState>(
                    handleCaptureOrganisation)));
          }
        });

        break;
    }
    return c.future;
  }

  Future<User> createUser() {
    var c = Completer<User>();
    var fUser = auth.createUser(state.email ?? 'null', state.password ?? '');
    fUser.then((value) {
      User u = User.create(state.email ?? '', value);
      Future fUpdate = data.set(u.dbReference, u.data);
      fUpdate.then((_) {
        c.complete(u);
      }).onError((error, stackTrace) {
        c.completeError(error ?? 'Failed to create user ${state.email}');
      });
    }).onError((error, stackTrace) {
      c.completeError(error ?? 'Failed to create user ${state.email}');
    });
    return c.future;
  }

  Future<User?> findUserByEmail(String email) {
    var c = Completer<User?>();
    var fUsers =
        data.query(User.objectType, field: User.emailLabel, value: email);
    fUsers.then((list) {
      if (list.isEmpty) {
        c.complete(null);
      } else {
        if (list.length == 1) {
          c.complete(User(data: list.first));
        } else {
          c.completeError('User $email appears more than once in the database');
        }
      }
    });

    return c.future;
  }

  Future<Organisation?> findOrganisationByName(String name) {
    var c = Completer<Organisation?>();
    var fOrgs = data.query(Organisation.objectType,
        field: Organisation.nameLabel, value: name);
    fOrgs.then((list) {
      if (list.isEmpty) {
        c.complete(null);
      } else {
        if (list.length == 1) {
          c.complete(Organisation(data: list.first));
        } else {
          c.completeError(
              'Organisation $name appears more than once in the database');
        }
      }
    });

    return c.future;
  }
}

class RegisterUserState implements CapturePasswordInputState {
  String? email;

  @override
  String? password;

  String? organisation;
}
