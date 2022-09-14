import 'package:billiards/beta/authenticate/register_user.dart';
import 'package:billiards/billiards_theme.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../../src/journey/journey_controller.dart';

class InviteUserPage extends StatelessWidget {

  final InviteUserInputState inputState;
  final PageEventHandler<InviteUserOutputState> handler;

  const InviteUserPage({Key? key, required this.inputState, required this.handler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    var email = '';
    return Scaffold(
      appBar: AuthenticatedInJourneyAppBar(title: 'Invite a User', email: inputState.userEmail, home: () { handler.handleEvent(Navigator.of(context), InviteUserOutputState(event: DefaultEvent.home));}),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Heading(text: 'Invite a User to join you at ${inputState.organisation}')),
                  FormRow(content: ErrorMessage(text: inputState.error,)),
                  Row(children: [
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                        flex: 2,
                        child: BilliardTextField(
                          label: 'Email',
                          help: 'Please provide the email address of the person you wish to invite',
                          initialValue: inputState.inviteeEmail,
                          valueBinder: (v) {
                            email = v;
                          },
                          validator: (v) {
                            final bool isValid = EmailValidator.validate(v ?? '');
                            if (!isValid) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        )

                        ),
                    Expanded(
                      child: Container(),
                    ),
                  ]),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () {
                          final nav = Navigator.of(context);
                          handler.handleEvent(nav, InviteUserOutputState(event: DefaultEvent.back));
                        },
                      ),
                      TextButton(
                        child: const Text('Next'),
                        onPressed: () {
                          final state = formKey.currentState as FormState;
                          if (state.validate()) {
                            final nav = Navigator.of(context);
                            handler.handleEvent(nav, InviteUserOutputState(event: DefaultEvent.next, inviteeEmail: email));
                          }
                        },
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}


class InviteUserInputState {
  final String userEmail;
  final String organisation;
  final String? inviteeEmail;
  final String? error;
  InviteUserInputState(this.userEmail, this.organisation, { this.inviteeEmail, this.error });


}

class InviteUserOutputState {
  final String? inviteeEmail;
  final DefaultEvent event;
  InviteUserOutputState({ required this.event, this.inviteeEmail});

}

