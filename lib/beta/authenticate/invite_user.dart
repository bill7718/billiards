import 'dart:async';

import 'package:billiards/authenticate.dart';
import 'package:billiards/data.dart';

import 'package:billiards/src/services/billiard_state.dart';
import 'package:billiards/src/journey/journey_controller.dart';

import 'package:billiards/pages.dart';
import 'package:flutter/material.dart';

import '../../src/data/data_service.dart';
import '../../src/pages/landing_page.dart';
import 'invite_user_page.dart';
import 'invited_user.dart';


class InviteUser extends JourneyController {
  final DataService data;
  final BilliardState coreState;

  final InviteUserState state = InviteUserState();

  InviteUser(this.data, this.coreState);

  @override
  void start(BuildContext context) {
    showInviteUser(context);
  }

  void showInviteUser(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InviteUserPage(
                  handler:
                      PageEventHandler<InviteUserOutputState>(handleInviteUser),
                  inputState: InviteUserInputState(
                      coreState.user.email, coreState.organisation?.name ?? ''),
                )));
  }

  Future<Widget> handleInviteUser(InviteUserOutputState pageOutputState) {
    var c = Completer<Widget>();
    switch (pageOutputState.event) {
      case DefaultEvent.back:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.home:
        c.complete(const BilliardsLandingPage());
        break;

      case DefaultEvent.next:
        state.email = pageOutputState.inviteeEmail;
        var fUser = findUserByEmail(state.email ?? '');
        fUser.then((user) {
          if (user == null) {
            var iu = InvitedUser.fromValues(state.email ?? '',
                coreState.user.id, coreState.organisation?.id ?? '');
            var f = data.set(iu.dbReference, iu.data);
            f.then((_) {
              c.complete(BilliardsLandingPage(
                message:
                    'When ${state.email} registers themselves they will be automatically linked to ${coreState.organisation?.name}',
              ));
            }).onError((error, stackTrace) {
              c.completeError(error ?? 'Error inviting ${state.email}');
            });
          } else {
            c.complete(InviteUserPage(
              handler:
                  PageEventHandler<InviteUserOutputState>(handleInviteUser),
              inputState: InviteUserInputState(
                  coreState.user.email, coreState.organisation?.name ?? '',
              error: 'User ${state.email} already exists. You cannot invite them to your organisation'),
            ));
          }
        }).onError((error, stackTrace) {
          c.completeError(error ?? 'Failed to invite user ${state.email}');
        });
        break;
    }
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
}

class InviteUserState {
  String? email;
}
