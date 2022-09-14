import 'package:billiards/billiards_theme.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

import '../../src/journey/journey_controller.dart';

class ConfirmOrganisationPage extends StatelessWidget {

  final ConfirmOrganisationInputState inputState;
  final PageEventHandler<ConfirmOrganisationOutputState> handler;

  const ConfirmOrganisationPage({Key? key, required this.inputState, required this.handler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    return Scaffold(
      appBar: UnauthenticatedInJourneyAppBar(title: 'Register as a new User', home: () { handler.handleEvent(Navigator.of(context), ConfirmOrganisationOutputState(event: DefaultEvent.home)); }),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Heading(text: 'Already Invited')),
                  FormRow(content: ErrorMessage(text: inputState.error,)),
                  FormRow(content: BodyText(
                    text: 'You have been invited to join ${inputState.organisation}. \n\nWhen you click Next your user will be created and you will be linked to this organisation.',
                  )),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () {
                          final nav = Navigator.of(context);
                          handler.handleEvent(nav, ConfirmOrganisationOutputState(event: DefaultEvent.back));
                        },
                      ),
                      TextButton(
                        child: const Text('Next'),
                        onPressed: () {
                          final state = formKey.currentState as FormState;
                          if (state.validate()) {
                            final nav = Navigator.of(context);
                            handler.handleEvent(nav, ConfirmOrganisationOutputState(event: DefaultEvent.next));
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


class ConfirmOrganisationInputState {
  final String organisation;
  final String? error;
  ConfirmOrganisationInputState(this.organisation, { this.error});

}

class ConfirmOrganisationOutputState {
  final DefaultEvent event;
  ConfirmOrganisationOutputState({ required this.event});

}

