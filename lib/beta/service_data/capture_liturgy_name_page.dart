import 'package:billiards/billiards_theme.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

import '../../src/journey/journey_controller.dart';

class CaptureLiturgyNamePage extends StatelessWidget {
  final CaptureLiturgyNameInputState inputState;
  final PageEventHandler<CaptureLiturgyNameOutputState> handler;

  const CaptureLiturgyNamePage(
      {Key? key, required this.inputState, required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    var name = '';
    return Scaffold(
      appBar:
      AuthenticatedInJourneyAppBar(title: 'Create a New Liturgy Item', email: inputState.email, home: (){}),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Heading(text: 'Add a Name')),
                  FormRow(
                      content: ErrorMessage(
                    text: inputState.error,
                  )),
                  FormRow(
                      content: BilliardTextField(
                    label: 'Name',
                    help: 'Please provide a name for the liturgy item',
                    initialValue: inputState.name,
                    valueBinder: (v) {
                      name = v;
                    },
                    validator: (v) {
                      if ((v?.trim() ?? '').isEmpty) {
                        return 'Please enter a value in the name';
                      }
                      return null;
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
                              CaptureLiturgyNameOutputState(
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
                                CaptureLiturgyNameOutputState(
                                    event: DefaultEvent.next, name: name));
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

class CaptureLiturgyNameInputState {
  final String email;
  final String? name;
  final String? error;
  CaptureLiturgyNameInputState(this.email, {this.name, this.error});
}

class CaptureLiturgyNameOutputState {
  final String? name;
  final DefaultEvent event;
  CaptureLiturgyNameOutputState({required this.event, this.name});
}
