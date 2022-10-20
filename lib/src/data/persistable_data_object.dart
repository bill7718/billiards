import 'dart:math';
import 'package:billiards/data.dart';

///
/// A [DataObject] that is designed to be persisted in a json database
///
/// It requires a type and generates and sets an id
///
abstract class PersistableDataObject extends DataObject {

  /// The label used for the id
  static const String idLabel = 'id';

  static const String createdLabel = 'created';

  /// The type of the data - used to determine the id of the object in the database
  final String type;

  ///
  /// Should be marked as true if this record is read from the database
  ///
  /// Used by external classes to determine if  this object was ever written to the database. In the event that
  /// it is to be deleted the external class can determine whether to make a delete call
  ///
  bool isOnDatabase = false;

  ///
  /// marked as true if the data on this object is updated
  ///
  bool isUpdated = false;

  PersistableDataObject(this.type, { Map<String, dynamic>? data}) : super(data ?? <String, dynamic>{}) {
    if (get(idLabel) == null) {
      set(idLabel, generateId());
    }
    isUpdated = false;
  }

  @override
  set(String label, dynamic value) {
    isUpdated = true;
    super.set(label, value);
  }

  String get id=>get(idLabel);

  String get dbReference=>'$type/$id';

  setCreated()=>set(createdLabel, currentTime());



  static String buildDBReference(String type, String id)=>'$type/$id';

}

///
/// Generates an id randomly
///
String generateId({Random? random, int length = 32}) {
  var r = random ?? Random();
  var response = '';
  while (response.length < length) {
    response = response + r.nextInt(9999999).toRadixString(36);
  }
  return response.substring(0, length);
}

int currentTime()=>DateTime.now().millisecondsSinceEpoch;

///
/// A Persisted Data Object that has a parent
///
abstract class EmbeddedPersistableDataObject extends PersistableDataObject {

  static const String parentDBRefLabel = 'parent';

  EmbeddedPersistableDataObject( String type,  String parentDBRef , { Map<String, dynamic>? data}) : super(type, data: data) {
    set(parentDBRefLabel, parentDBRef);
  }

  @override
  String get dbReference=>'${get(parentDBRefLabel)}/$type/$id';
}