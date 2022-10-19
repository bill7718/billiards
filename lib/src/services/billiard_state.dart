
import 'package:billiards/beta/services/organisation.dart';
import 'package:billiards/src/authentication/user.dart';


/// The core application state that is common to all journeys
class BilliardState {

  /// The logged in user
  late User user;

  /// The organisation that the user accessing
  Organisation? organisation;

}