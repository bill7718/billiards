import 'package:billiards/billiards_theme.dart';
import 'package:billiards/journey.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';


class CaptureLiturgyContentPage extends StatelessWidget {
  final CaptureLiturgyContentInputState inputState;
  final PageEventHandler<CaptureLiturgyContentOutputState> handler;

  const CaptureLiturgyContentPage(
      {Key? key, required this.inputState, required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    var text = '';
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
                  Center(child: Heading(text: 'Add The Liturgy Content for ${inputState.name}')),
                  FormRow(
                      content: ErrorMessage(
                    text: inputState.error,
                  )),
                  FormRow(
                    flex: 5,
                      content: BilliardTextField(
                    label: '',
                    help: 'Please provide the content for this liturgy item',
                    initialValue: inputState.text,
                    maxLines: 20,
                    valueBinder: (v) {
                      text = v;
                    },
                    validator: (v) {
                      if ((v?.trim() ?? '').isEmpty) {
                        return 'Please provide the Liturgy before you go to the next step';
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
                              CaptureLiturgyContentOutputState(
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
                                CaptureLiturgyContentOutputState(
                                    event: DefaultEvent.next, text: text));
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

class CaptureLiturgyContentInputState {
  final String email;
  final String name;
  final String? text;
  final String? error;
  CaptureLiturgyContentInputState(this.email, this.name, {this.text, this.error});
}

class CaptureLiturgyContentOutputState {
  final String? text;
  final DefaultEvent event;
  CaptureLiturgyContentOutputState({required this.event, this.text});
}
