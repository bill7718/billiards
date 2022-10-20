
import 'package:billiards/data.dart';

import '../../beta/data/persistable_data_object.dart';

///
/// Models a User in the current system
///
class User extends PersistableDataObject {

  static const String objectType = 'User';

  /// Identifies the type of [DataObjectRelationship] where a User belongs to an [Organisation]
  static const String userToOrganisation = 'userToOrganisation';

  static const String emailLabel = 'email';
  static const String userIdLabel = 'userId';
  static const String lastLoginLabel = 'lastLogin';
  static const String lastButOneLoginLabel = 'lastButOneLogin';
  static const String loginFailureCountLabel = 'loginFailureCount';
  static const String lastFailedLoginLabel = 'lastFailedLogin';

  User({Map<String, dynamic>? data }) : super(objectType, data: data);

  User.create(String email, String userId) : super(objectType) {
    set(emailLabel, email);
    set(userIdLabel, userId);
  }

  /// The user's email address
  String get email=> get(emailLabel) ?? (throw UserException('User record must always have a $emailLabel'));

  /// An external id for the user. For Firebase implementations this will hold the [uid]
  String get userId=> get(userIdLabel) ?? (throw UserException('User record must always have a $userIdLabel'));

  /// The date/time of the most recent login
  DateTime? get lastLogin=>getDateTime(lastLoginLabel);

  /// The date/time of the login before the most recent one
  DateTime? get lastButOneLogin=>getDateTime(lastButOneLoginLabel);

  /// The date/time of the last failed login. Only held if the last login was not successful
  DateTime? get lastFailedLogin=>getDateTime(lastFailedLoginLabel);

  /// The number of consecutive failed login attempts
  int get loginFailureCount=> get(loginFailureCountLabel) ?? 0;


  void setLoginDateTime(DateTime d) {
    setDateTime(lastButOneLoginLabel, lastLogin);
    setDateTime(lastLoginLabel, d);
  }
}

/// Generic Exception class for [User] Object Exceptions
class UserException implements Exception {
  // ignore: unused_field
  final String _message;

  UserException(this._message);
}