
import 'package:billiards/data.dart';

///
/// Models a User in the current system
///
class User extends PersistableDataObject {

  static const String objectType = 'User';

  /// Identifies the type of [DataObjectRelationship] where a User belongs to an [Organisation]
  static const String userToOrganisation = 'userToOrganisation';

  static const String emailLabel = 'email';
  static const String userIdLabel = 'userId';

  User({Map<String, dynamic>? data }) : super(objectType, data: data);

  User.fromValues(String email, String userId) : super(objectType) {
    set(emailLabel, email);
    set(userIdLabel, userId);
  }

  /// The user's email address
  String? get email=>get(emailLabel);

  /// An external id for the user. For Firebase implementations this will hold the [uid]
  String? get userId=>get(userIdLabel);
}