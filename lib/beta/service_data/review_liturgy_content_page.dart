import 'package:billiards/billiards_theme.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

import '../../src/journey/journey_controller.dart';

class ReviewLiturgyContentPage extends StatelessWidget {
  final ReviewLiturgyContentInputState inputState;
  final PageEventHandler<ReviewLiturgyContentOutputState> handler;

  const ReviewLiturgyContentPage(
      {Key? key, required this.inputState, required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    var text = '';
    return Scaffold(
      appBar: AuthenticatedInJourneyAppBar(
          title: 'Create a New Liturgy Item',
          email: inputState.email,
          home: () {}),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Heading(
                          text:
                              'Review The Liturgy Content for ${inputState.name}')),
                  FormRow(
                      content: ErrorMessage(
                    text: inputState.error,
                  )),
                  FormRow(
                    flex: 5,
                    content: BodyText(text: inputState.text),
                  ),
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
                              ReviewLiturgyContentOutputState(
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
                                ReviewLiturgyContentOutputState(
                                    event: DefaultEvent.next));
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

class ReviewLiturgyContentInputState {
  final String email;
  final String name;
  final String text;
  final String? error;
  ReviewLiturgyContentInputState(this.email, this.name, this.text,
      {this.error});
}

class ReviewLiturgyContentOutputState {
  final DefaultEvent event;
  ReviewLiturgyContentOutputState({required this.event});
}
