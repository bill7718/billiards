import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/src/authentication/capture_email_page.dart';
import 'package:billiards/src/journey/journey_controller.dart';
import 'package:flutter/material.dart';

void main() {


  showPage(
    CaptureEmailPage(handler: PageEventHandler<CaptureEmailOutputState>(handleCaptureEmail),
      inputState: CaptureEmailInputState(null, error: 'This email address is already in use'),)
  );
}

Future<Widget> handleCaptureEmail(CaptureEmailOutputState output) async {
  return Card( child: Text(output.toString()));
}