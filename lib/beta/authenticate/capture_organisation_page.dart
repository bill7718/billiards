import 'package:billiards/billiards_theme.dart';
import 'package:billiards/journey.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

///
/// This page captures the name of the organisation
///
class CaptureOrganisationPage extends StatelessWidget {
  static const String titleText = 'Register as a new User';
  static const String formTitleText = 'Register';

  static const String organisationLabel = 'Organisation Name';
  static const String organisationHelp =
      'Please provide the name of the organisation you are registering with. This is normally your church.';
  static const String organisationError =
      'Please enter a name for the organisation.';

  static const String nextButtonText = 'Next';
  static const String backButtonText = 'Back';

  final CaptureOrganisationInputState inputState;
  final PageEventHandler<CaptureOrganisationOutputState> handler;

  const CaptureOrganisationPage(
      {Key? key, required this.inputState, required this.handler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    var organisation = '';
    BilliardFormTheme? theme = Theme.of(context).extension<BilliardFormTheme>();
    if (theme == null) { throw Exception('Missing Billiard Form Theme in Capture Organisation Page');}

    final BilliardFormTheme formTheme = theme;
    return Scaffold(
      appBar: UnauthenticatedInJourneyAppBar(
          title: titleText,
          home: () {
            handler.handleEvent(Navigator.of(context),
                CaptureOrganisationOutputState(event: DefaultEvent.home));
          }),
      body: Container(
          margin: formTheme.margin,
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Heading(text: formTitleText)),
                  FormRow(
                      content: ErrorMessage(
                    text: inputState.error,
                  )),
                  FormRow(
                      content: BilliardTextField(
                    label: organisationLabel,
                    help: organisationHelp,
                    initialValue: inputState.organisation,
                    valueBinder: (v) {
                      organisation = v;
                    },
                    validator: (v) {
                      if ((v ?? '').isEmpty) {
                        return organisationError;
                      }

                      return null;
                    },
                  )),
                  SizedBox(
                      height: Theme.of(context)
                              .extension<BilliardsTheme>()
                              ?.blankLineHeight ??
                          0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text(backButtonText),
                        onPressed: () {
                          final nav = Navigator.of(context);
                          handler.handleEvent(
                              nav,
                              CaptureOrganisationOutputState(
                                  event: DefaultEvent.back));
                        },
                      ),
                      TextButton(
                        child: const Text(nextButtonText),
                        onPressed: () {
                          final state = formKey.currentState as FormState;
                          if (state.validate()) {
                            final nav = Navigator.of(context);
                            handler.handleEvent(
                                nav,
                                CaptureOrganisationOutputState(
                                    event: DefaultEvent.next,
                                    organisation: organisation));
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

///
/// Input into the [CaptureOrganisationPage] screen
///
class CaptureOrganisationInputState {
  final String? _organisation;
  final String? error;
  CaptureOrganisationInputState(this._organisation, {this.error});

  String? get organisation => _organisation;
}

///
/// Output from the [CaptureOrganisationPage] screen
///
class CaptureOrganisationOutputState {
  final String? organisation;
  final DefaultEvent event;
  CaptureOrganisationOutputState({required this.event, this.organisation});
}
