

import 'dart:math';

import 'persistable_data_object.dart';

class Audit extends EmbeddedPersistableDataObject {

  static const String objectType = 'Audit';

  static const String auditEventLabel = 'event';


  Audit(String parentDBRef, {Map<String, dynamic>? data }) : super(objectType, parentDBRef, data: data);

  Audit.fromValues(String parentDBRef, String event, {Map<String, dynamic>? auditData }) : super(objectType, parentDBRef) {
      set(auditEventLabel, event);
      setCreated();
      data.addAll(auditData ?? <String, dynamic>{});
  }

}