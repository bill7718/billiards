import 'package:billiards/billiards_theme.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

import '../../src/journey/journey_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginInputState inputState;
  final PageEventHandler<LoginOutputState> handler;

  const LoginPage(
      {Key? key, required this.inputState, required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    var password = '';
    var email = '';
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
        child: Text('Login'),
      )),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Heading(text: 'Login')),
                  FormRow(
                      content: BilliardTextField(
                    obscure: true,
                    label: 'Email',
                    valueBinder: (v) {
                      email = v;
                    },
                    validator: (v) {
                      if ( (v ?? '').isEmpty) {
                        return 'Please enter an email address';
                      }
                      return null;
                    },
                  )),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  FormRow(
                      content: BilliardTextField(
                        obscure: true,
                        label: 'Password',
                        valueBinder: (v) {
                          password = v;
                        },
                        validator: (v) {
                          if ( (v ?? '').isEmpty) {
                            return 'Please enter a password';
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
                              LoginOutputState(
                                  event: LoginEvent.back));
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
                                LoginOutputState(
                                    event: LoginEvent.next,
                                    email: email,
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

class LoginInputState {

  LoginInputState();

}

class LoginOutputState {
  final String? password;
  final String? email;
  final LoginEvent event;
  LoginOutputState({required this.event, this.email, this.password});
}

enum LoginEvent { next, back }
