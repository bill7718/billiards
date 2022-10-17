import 'package:billiards/beta/service_data/split_service_content.dart';
import 'package:billiards/beta/service_data/service_theme.dart';
import 'package:billiards/beta/service_data/show_service_content.dart';
import 'package:billiards/beta/service_data/text_part.dart';
import 'package:billiards/billiards_theme.dart';
import 'package:billiards/journey.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';

class ReviewLiturgyContentPage extends StatefulWidget {
  final ReviewLiturgyContentInputState inputState;
  final PageEventHandler<ReviewLiturgyContentOutputState> handler;

  const ReviewLiturgyContentPage(
      {Key? key, required this.inputState, required this.handler})
      : super(key: key);

  @override
  State<StatefulWidget> createState()=>ReviewLiturgyContentPageState();
}

class ReviewLiturgyContentPageState extends State<ReviewLiturgyContentPage>{

  bool parsed = false;
  List<List<TextPart>> pages = <List<TextPart>>[];

  @override
  void initState() {
    super.initState();
    parsed = false;
    pages.clear();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    final serviceTheme = ServiceTheme(60, 1600, 1200, Colors.black, Colors.white);
    return Scaffold(
      appBar: AuthenticatedInJourneyAppBar(
          title: 'Create a New Liturgy Item',
          email: widget.inputState.email,
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
                              'Review The Liturgy Content for ${widget.inputState.name}')),
                  FormRow(
                      content: ErrorMessage(
                    text: widget.inputState.error,
                  )),
                  if (!parsed)
                    FormRow(content: Offstage(
                      child: SplitServiceContent(content: widget.inputState.text, displayTheme:
                      serviceTheme, callback: (l) {
                        setState(() {
                          pages = l;
                          parsed = true;
                        });
                      },),
                    )),
                  if (parsed) Expanded ( child: FormRow(
                    flex: 5,
                    content: ShowServiceContent(pages: pages, theme: serviceTheme,),
                  )),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () {
                          final nav = Navigator.of(context);
                          widget.handler.handleEvent(
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
                            widget.handler.handleEvent(
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
