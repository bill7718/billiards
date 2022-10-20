import 'package:billiards/data.dart';
import 'package:billiards/src/data/persistable_data_object.dart';

///
/// Data Object for an Organisation
///
/// An organisation is the organising entity for which the [Liturgy] and other items are stored.
///
/// Typically an Organisation is a church and a user belongs to just one Organisation.
///
class Organisation extends PersistableDataObject {

  static const String objectType = 'Organisation';
  static const String nameLabel = 'name';

  Organisation({Map<String, dynamic>? data }) : super(objectType, data: data);

  String get name=>get(nameLabel);

  set name(String? s)=> s != null ? set(nameLabel, s) :throw DataObjectException('Must not set organisation name to null');
}