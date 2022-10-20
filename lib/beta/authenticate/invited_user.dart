

import 'package:billiards/src/data/persistable_data_object.dart';

class InvitedUser extends PersistableDataObject {

  static const String objectType = 'InvitedUser';

  static const String emailLabel = 'inviteeEmail';
  static const String userIdLabel = 'invitingUserId';
  static const String organisationIdLabel = 'organisationId';

  InvitedUser({Map<String, dynamic>? data }) : super(objectType, data: data);

  InvitedUser.fromValues(String email, String userId, String organisationId) : super(objectType) {
    set(emailLabel, email);
    set(userIdLabel, userId);
    set(organisationIdLabel, organisationId);
    setCreated();
  }

}