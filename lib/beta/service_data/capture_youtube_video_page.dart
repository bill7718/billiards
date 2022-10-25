import 'package:billiards/billiards_theme.dart';
import 'package:billiards/widgets.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../src/journey/journey_controller.dart';

class CaptureYouTubeVideoPage extends StatefulWidget {
  final CaptureYouTubeVideoInputState inputState;
  final PageEventHandler<CaptureYouTubeVideoOutputState> handler;

  const CaptureYouTubeVideoPage({Key? key, required this.inputState, required this.handler}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CaptureYouTubeVideoPageState();
}

class CaptureYouTubeVideoPageState extends State<CaptureYouTubeVideoPage> {
  late String name;
  late String videoId;

  @override
  void initState() {
    name = widget.inputState.name ?? '';
    videoId = widget.inputState.videoId ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey();
    return Scaffold(
      appBar: AuthenticatedInJourneyAppBar(title: 'Create a New You Tube Video', email: widget.inputState.email, home: () {}),
      body: Container(
          margin: const EdgeInsets.all(25),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Heading(text: 'Add a Name For the Video')),
                  FormRow(
                      content: ErrorMessage(
                    text: widget.inputState.error,
                  )),
                  FormRow(
                      content: BilliardTextField(
                    label: 'Name',
                    help: 'Please provide a name for the you tube video',
                    initialValue: name,
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
                  FormRow(
                      content: BilliardTextField(
                    label: 'Video Id',
                    help: 'Please enter the id of the video or just copy and paste the url from You tube. We will get the video id from the url for you.',
                    initialValue: videoId,
                    valueBinder: (v) {
                      var index = v.toString().indexOf('?v=');
                      if (index == -1) {
                        setState(() {
                          videoId = v;
                        });
                      } else {
                        setState(() {
                          videoId = v.toString().substring(index + 3);
                        });
                      }
                    },
                    validator: (v) {
                      if ((v?.trim() ?? '').isEmpty) {
                        return 'Please enter a value in the video id';
                      }
                      return null;
                    },
                  )),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  if (videoId.isNotEmpty) Expanded ( child : FormRow (content: BilliardsYouTubePlayer(videoId: videoId,))),
                  SizedBox(height: Theme.of(context).extension<BilliardsTheme>()?.blankLineHeight ?? 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        child: const Text('Back'),
                        onPressed: () {
                          final nav = Navigator.of(context);
                          widget.handler.handleEvent(nav, CaptureYouTubeVideoOutputState(event: DefaultEvent.back));
                        },
                      ),
                      TextButton(
                        child: const Text('Next'),
                        onPressed: () {
                          final state = formKey.currentState as FormState;
                          if (state.validate()) {
                            final nav = Navigator.of(context);
                            widget.handler.handleEvent(nav, CaptureYouTubeVideoOutputState(event: DefaultEvent.next, name: name));
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

class CaptureYouTubeVideoInputState {
  final String email;
  final String? name;
  final String? videoId;
  final String? error;
  CaptureYouTubeVideoInputState(this.email, {this.name, this.videoId, this.error});
}

class CaptureYouTubeVideoOutputState {
  final String? name;
  final String? videoId;
  final DefaultEvent event;
  CaptureYouTubeVideoOutputState({required this.event, this.name, this.videoId});
}

class BilliardsYouTubePlayer extends StatelessWidget {
  final String videoId;

  const BilliardsYouTubePlayer({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller =
    YoutubePlayerController.fromVideoId(videoId: videoId, params: const YoutubePlayerParams());

    return YoutubePlayer(
      controller: controller,
      aspectRatio: 16 / 9,
    );
  }

//if (videoId.isNotEmpty) FormRow (content: SizedBox (height: 400, child :Image.network(YoutubePlayerController.getThumbnail(videoId: videoId),))),
}
