
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
  static const String lastLoginLabel = 'lastLogin';
  static const String lastButOneLoginLabel = 'lastButOneLogin';
  static const String loginFailureCountLabel = 'loginFailureCount';

  User({Map<String, dynamic>? data }) : super(objectType, data: data);

  User.create(String email, String userId) : super(objectType) {
    set(emailLabel, email);
    set(userIdLabel, userId);
  }

  /// The user's email address
  String get email=> get(emailLabel) ?? (throw UserException('User record must always have a $emailLabel'));

  /// An external id for the user. For Firebase implementations this will hold the [uid]
  String get userId=> get(userIdLabel) ?? (throw UserException('User record must always have a $userIdLabel'));

  DateTime? get lastLogin=>getDateTime(lastLoginLabel);

  DateTime? get lastButOneLogin=>getDateTime(lastButOneLoginLabel);

  int get loginFailureCount=> get(loginFailureCountLabel) ?? 0;
  //
  // void resetLoginFailureCount()=>set(loginFailureCountLabel, null);
  //
  // void incrementLoginFailureCount() =>set(loginFailureCountLabel, loginFailureCount + 1);

  void setLoginDateTime(DateTime d) {
    setDateTime(lastButOneLoginLabel, lastLogin);
    setDateTime(lastLoginLabel, d);
  }
}

class UserException implements Exception {
  // ignore: unused_field
  final String _message;

  UserException(this._message);
}