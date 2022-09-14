import 'package:flutter/material.dart';

///
/// An Appbar that is used when user is not authenticated and is not in a journey
/// It contains
/// - a title
///
class UnauthenticatedOutJourneyAppBar extends AppBar {
  UnauthenticatedOutJourneyAppBar({Key? key, required String title})
      : super(
          key: key,
          title: Center(child: Text(title)),
        );
}

///
/// An Appbar that is used when user is not authenticated and is in a journey
/// It contains
/// - a title
/// - a home button - if clicked the journey handles the required actions. Typically this would take the user out of the journey and
/// back to a 'home' screen
///
class UnauthenticatedInJourneyAppBar extends AppBar {
  UnauthenticatedInJourneyAppBar(
      {Key? key, required String title, required Function home})
      : super(
            key: key,
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                home();
              },
            ),
            title: Center(child: Text(title)));
}

///
/// An Appbar that is used when user is authenticated and is not in a journey
/// It contains
/// - a title
/// - a person icon which has the email address of the user as a tooltip. It may later be linked to some additional functionality
///
class AuthenticatedOutJourneyAppBar extends AppBar {
  AuthenticatedOutJourneyAppBar(
      {Key? key, required String title, required String email})
      : super(key: key, title: Center(child: Text(title)), actions: [
          IconButton(
              tooltip: email,
              onPressed: () {},
              icon: const Icon(
                Icons.person,
              ))
        ]);
}

///
/// An Appbar that is used when user is authenticated and is part of a journey
/// It contains
/// - a title
/// - a home button - if clicked the journey handles the required actions. Typically this would take the user out of the journey and
/// back to a 'home' screen
/// - a person icon which has the email address of the user as a tooltip. It may later be linked to some additional functionality
///
class AuthenticatedInJourneyAppBar extends AppBar {
  AuthenticatedInJourneyAppBar(
      {Key? key,
      required String title,
      required String email,
      required Function home})
      : super(
            key: key,
            leading: IconButton(
                onPressed: () {
                  home();
                },
                icon: const Icon(
                  Icons.home,
                )),
            title: Center(child: Text(title)),
            actions: [
              IconButton(
                  tooltip: email,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                  ))
            ]);
}

///
/// Standard Text field which uses the [bodyText2] style defined in the theme
///
class BodyText extends StatelessWidget {
  final String text;
  const BodyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}

///
/// Standard Text field which uses the [headline5] style defined in the theme
///
class Heading extends StatelessWidget {
  final String text;
  const Heading({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline5,
    );
  }
}

///
/// Shows an error as standard body text but uses the error color define in the theme
///
class ErrorMessage extends StatelessWidget {
  final String? text;
  const ErrorMessage({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: Theme.of(context)
          .textTheme
          .bodyText2
          ?.copyWith(color: Theme.of(context).errorColor),
    );
  }
}
