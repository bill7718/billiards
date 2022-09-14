import 'package:billiards/beta/authenticate/register_user.dart';
import 'package:billiards/billiards_theme.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

import '../../src/journey/journey_controller.dart';

///
/// The first page in the register journey
///
/// It enables a user to record their email address. This is passed to the
/// rest of the journey for processing
///
class CapturePasswordPage extends StatelessWidget {
  final CapturePasswordInputState inputState;
  final PageEventHandler<CapturePasswordOutputState> handler;

  const CapturePasswordPage(
      {Key? key, required this.inputState, required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    var password = '';
    var repeatPassword = '';
    return Scaffold(
      appBar: UnauthenticatedInJourneyAppBar(title: 'Register as a new User', home: () { handler.handleEvent(Navigator.of(context), CapturePasswordOutputState(event: DefaultEvent.home)); }),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Heading(text: 'Register')),
                  FormRow(
                      content: BilliardTextField(
                    obscure: true,
                    label: 'Password',
                    help: 'Please provide a password for your account',
                    valueBinder: (v) {
                      password = v;
                    },
                    validator: (v) {
                      if ( (v ?? '').length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  )),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  FormRow(
                      content: BilliardTextField(
                        obscure: true,
                        label: 'Repeat Password',
                        valueBinder: (v) {
                          repeatPassword = v;
                        },
                        validator: (v) {
                          if ( v != password) {
                            return 'Passwords must be the same';
                          }
                        },
                      )),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () {
                          final nav = Navigator.of(context);
                          handler.handleEvent(
                              nav,
                              CapturePasswordOutputState(
                                  event: DefaultEvent.back));
                        },
                      ),
                      TextButton(
                        child: const Text('Next'),
                        onPressed: () {
                          final state = formKey.currentState as FormState;
                          if (state.validate()) {
                            final nav = Navigator.of(context);
                            handler.handleEvent(
                                nav,
                                CapturePasswordOutputState(
                                    event: DefaultEvent.next,
                                    password: password));
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

class CapturePasswordInputState {
  final String? _password;
  CapturePasswordInputState(this._password);

  String? get password => _password;
}

class CapturePasswordOutputState {
  final String? password;
  final DefaultEvent event;
  CapturePasswordOutputState({required this.event, this.password});
}

