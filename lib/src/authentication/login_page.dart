import 'package:billiards/billiards_theme.dart';
import 'package:billiards/journey.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

///
/// A standard login page with email and password
///
class LoginPage extends StatelessWidget {

  static const String emailError = 'Please enter your email address';
  static const String passwordError = 'Please enter your password';

  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String nextButtonText = 'Next';
  static const String backButtonText = 'Back';

  final LoginInputState inputState;
  final PageEventHandler<LoginOutputState> handler;

  const LoginPage({Key? key, required this.inputState, required this.handler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final formTheme = BilliardFormTheme.get(context);
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
            margin: formTheme.margin,
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Heading(text: 'Login')),
                    FormRow(
                        content: ErrorMessage(
                      text: inputState.error,
                    )),
                    FormRow(
                        content: BilliardTextField(
                      initialValue: inputState.email,
                      obscure: true,
                      label: emailLabel,
                      valueBinder: (v) {
                        email = v;
                      },
                      validator: (v) {
                        if ((v ?? '').isEmpty) {
                          return emailError;
                        }
                        return null;
                      },
                    )),
                    SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                    FormRow(
                        content: BilliardTextField(
                      obscure: true,
                      initialValue: inputState.password,
                      label: passwordLabel,
                      valueBinder: (v) {
                        password = v;
                      },
                      // ignore: body_might_complete_normally_nullable
                      validator: (v) {
                        if ((v ?? '').isEmpty) {
                          return passwordError;
                        }
                      },
                    )),
                    SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          child: const Text(backButtonText),
                          onPressed: () {
                            final nav = Navigator.of(context);
                            handler.handleEvent(nav, LoginOutputState(event: DefaultEvent.back));
                          },
                        ),
                        TextButton(
                          child: const Text(nextButtonText),
                          onPressed: () {
                            final state = formKey.currentState as FormState;
                            if (state.validate()) {
                              final nav = Navigator.of(context);
                              handler.handleEvent(nav, LoginOutputState(event: DefaultEvent.next, email: email, password: password));
                            }
                          },
                        )
                      ],
                    )
                  ],
                ))),
      );
    } catch (ex, st) {
      final nav = Navigator.of(context);
      handler.handleException(nav, ex, st: st);
      return Container();
    }
  }
}

///
/// The input data for the Login page
///
class LoginInputState {
  final String? password;
  final String? email;
  final String? error;

  LoginInputState({this.email, this.password, this.error});
}

///
/// The output data from the Login page
///
class LoginOutputState {
  final String? password;
  final String? email;
  final DefaultEvent event;
  LoginOutputState({required this.event, this.email, this.password});
}
