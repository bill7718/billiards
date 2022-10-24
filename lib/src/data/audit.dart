import 'package:billiards/data.dart';

///
/// Defines an Audit object that can be used to help in the creation of Audit records
///
class Audit extends EmbeddedPersistableDataObject {

  static const String objectType = 'Audit';
  static const String auditEventLabel = 'event';

  Audit(String parentDBRef, { Map<String, dynamic>? data }) : super(objectType, parentDBRef, data: data);

  Audit.fromValues(String parentDBRef, String event, { Map<String, dynamic>? auditData }) : super(objectType, parentDBRef) {
      set(auditEventLabel, event);
      setCreated();

      if (auditData != null) {
        for (var k in auditData.keys) {
          set(k, auditData[k]);
        }
      }
  }

  Audit.fromMap(Map<String, dynamic> data) : super (objectType, data['parent'], data: data);

  String get event => get(auditEventLabel);
}