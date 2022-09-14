import 'package:billiards/alpha/show_page.dart';
import 'package:billiards/authenticate.dart';
import 'package:billiards/src/journey/journey_controller.dart';
import 'package:flutter/material.dart';


void main() {


  showPage(
    InviteUserPage(handler: PageEventHandler<InviteUserOutputState>(handleInviteUser),
      inputState: InviteUserInputState('a@b.com', 'Curveball', ),)
  );
}

Future<Widget> handleInviteUser(InviteUserOutputState output) async {
  return Card( child: Text(output.toString()));
}