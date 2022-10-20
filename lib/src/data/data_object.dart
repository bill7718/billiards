import 'dart:convert';

///
/// Containing class for an Object that store data in the form of a Map.
///
abstract class DataObject extends Object {
  /// {@template immutable}
  /// If true then the [set] method throws an exception
  /// If false (or null) then the [set] method continues as normal
  /// {@endtemplate}

  /// Label for immutability indicator.
  ///
  ///
  /// {@macro immutable}
  static const String immutableLabel = 'immutable';

  /// Stores the data for this object
  final Map<String, dynamic> _data;

  /// The listeners that are triggered if the [set] method is called on a label
  final Map<String, List<Function>> _listeners = <String, List<Function>>{};

  DataObject(this._data);

  ///
  /// Set the data corresponding to the label with the value
  ///
  /// If the value is null the label is removed from the Map.
  ///
  /// Listeners are called if the value changes
  ///
  void set(String label, dynamic value) {
    if (immutable) {
      throw DataObjectException(
          'Cannot set $runtimeType. It is immutable: $_data');
    }
    var oldValue = get(label);
    if (value == null) {
      _data.remove(label);
    } else {
      _data[label] = value;
    }
    if (value != oldValue) {
      _notify(label);
    }
  }

  /// Notify listeners of a change to this element in the data object
  ///
  ///
  void _notify(String label) {
    for (var listener in _listeners[label] ?? []) {
      listener();
    }
  }

  ///
  /// Merge the data from the map into this [DataObject]
  ///
  void merge(Map<String, dynamic> map) {
    for (var key in map.keys) {
      set(key, map[key]);
    }
  }

  ///
  /// Get the data corresponding to the label from the DataObject
  ///
  dynamic get(String label) => _data[label];

  /// Get the value as a [DateTime] Object
  ///
  /// Returns a DateTime based on the data being an integer number of milliseconds since the Epoch
  ///
  DateTime? getDateTime(String label) {
    return _data[label] == null ? null : DateTime.fromMillisecondsSinceEpoch(data[label]);
  }

  /// Set the [DateTime] Object
  ///
  /// Sets the value as a time in milliseconds since Epoch
  setDateTime(String label, DateTime? value) {
    if (value == null) {
      set(label, value);
    } else {
      set(label, value.millisecondsSinceEpoch);
    }
  }



  /// {@macro immutable}
  bool get immutable => get(immutableLabel) ?? false;

  ///
  /// Returns a copy of the Map containing the data in this DataObject
  ///
  Map<String, dynamic> get data {
    var response = <String, dynamic>{};
    for (var key in _data.keys) {
      response[key] = get(key);
    }
    return response;
  }

  ///
  /// Used to validate the data in this DataObject
  ///
  /// null - valid
  /// notnull - invalid - classes normally return a code which is used ot look up the error message
  ///
  /// Where [fields] are specified the method should validate only the fields in the list. This enables
  /// a screen containing only a subset of the data for this object to check that it is valid before
  /// moving on. Or by passing just one field in the list an individual screen element can be validated.
  ///
  String? validate({List<String>? fields}) => null;

  ///
  /// Adds a listener [Function] that is called whenever the field corresponding to the
  /// [label] is updated.
  ///
  void addListener(String label, Function listener) {
    _listeners[label] ??= <Function>[];
    _listeners[label]!.add(listener);
  }

  ///
  /// Remove a listener that has been previously added. If the listener is not found the method
  /// does nothing.
  ///
  void removeListener(String label, Function listener) {
    _listeners[label] ??= <Function>[];
    _listeners[label]!.remove(listener);
  }

  ///
  /// Convert the data in the [_map] to a Json Object
  ///
  dynamic toJson() => const JsonEncoder().convert(data);


}

class DataObjectException implements Exception {
  // ignore: unused_field
  final String _message;

  DataObjectException(this._message);
}
