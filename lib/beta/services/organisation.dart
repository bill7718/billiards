

import 'package:billiards/beta/data/persistable_data_object.dart';

class Organisation extends PersistableDataObject {


  static const String objectType = 'Organisation';

  static const String nameLabel = 'name';

  Organisation({Map<String, dynamic>? data }) : super(objectType, data: data);

  Organisation.fromValues(String name) : super(objectType) {
    set(nameLabel, name);
  }

  String get name=>get(nameLabel);
}