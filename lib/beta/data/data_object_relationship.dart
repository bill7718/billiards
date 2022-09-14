

import 'dart:async';

import 'data_service.dart';
import 'persistable_data_object.dart';

///
/// Models the relationship between 2 [PersistableDataObject]s
///
class DataObjectRelationship extends PersistableDataObject {
  static const String objectType = 'DataObjectRelationship';

  static const String fromIdLabel = 'fromId';
  static const String toIdLabel = 'toId';
  static const String relationshipTypeLabel = 'relationshipType';

  static const String sequenceNumberLabel = 'sequence';

  static const String activeLabel = 'active';

  /// If this attribute is true then the relationship is not present
  ///
  /// So where for example a Student has no exam certificates we would model that by creating a relationship
  /// with the absent value set to true. If the relationship is not present this means that we have no record of the
  /// students exam certificates but this might be because we have not asked about them.
  static const String absentLabel = 'absent';

  DataObjectRelationship({Map<String, dynamic>? data}) : super(objectType, data: data);

  DataObjectRelationship.data({required PersistableDataObject from, required PersistableDataObject to, required String type, int? sequenceNumber})
      : super(objectType) {
    set(relationshipTypeLabel, type);
    set(fromIdLabel, from.id);
    set(toIdLabel, to.id);
    set(sequenceNumberLabel, sequenceNumber);
  }


  String? get relationshipType => get(relationshipTypeLabel);
  String? get toId => get(toIdLabel);
  String? get fromId => get(fromIdLabel);
  int? get sequence => get(sequenceNumberLabel);

  bool get active => super.get(activeLabel) ?? true;

  set sequence(int? s) => set(sequenceNumberLabel, s);


  static Future<List<DataObjectRelationship>> list(DataService data, String fromId, String type) async {
    var c = Completer<List<DataObjectRelationship>>();

    var f = data.query(objectType, field: fromIdLabel, value: fromId);
    f.then( (list) {
      var response = <DataObjectRelationship>[];
      for (var item in list) {
        DataObjectRelationship rel = DataObjectRelationship(data: item);
        if (rel.relationshipType == type) {
          response.add(rel);
        }
      }
      c.complete(response);
    });

    return c.future;
  }
}




