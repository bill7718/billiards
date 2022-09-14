import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/authenticate.dart';
import 'package:billiards/src/authentication/capture_email_page.dart';
import 'package:billiards/src/journey/journey_controller.dart';
import 'package:flutter/material.dart';

void main() {


  showPage(
    CapturePasswordPage(handler: PageEventHandler<CapturePasswordOutputState>(handleCapturePassword),
      inputState: CapturePasswordInputState(null),)
  );
}

Future<Widget> handleCapturePassword(CapturePasswordOutputState output) async {
  return Card( child: Text(output.toString()));
}