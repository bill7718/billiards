
import 'package:billiards/data.dart';

import '../data/persistable_data_object.dart';

class Liturgy extends EmbeddedPersistableDataObject {

  static const String objectType = 'Liturgy';

  static const String nameLabel = 'name';
  static const String textLabel = 'text';


  Liturgy(String parentDBRef, {Map<String, dynamic>? data }) : super(objectType, parentDBRef, data: data);

  Liturgy.fromValues(String parentDBRef, String name, String text ) : super(objectType, parentDBRef) {
    set(nameLabel, name);
    set(textLabel, text);
  }

}