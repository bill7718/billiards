
import 'dart:async';
import 'data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FlutterFirebaseService implements DataService {

  @override
  Future<Map<String, dynamic>>get(String ref) {
    Completer<Map<String, dynamic>> c =  Completer<Map<String, dynamic>>();

    try {
      Future<DocumentSnapshot<Map<String, dynamic>>> f = FirebaseFirestore.instance.doc(ref).get();
      f.then((document) {
        var data = document.data();
        if (data != null) {
          c.complete(data);
        } else {
          c.completeError('Document with reference $ref not found');
        }
      }).catchError((ex) {
        c.completeError(ex);
      });
    } catch (ex) {
      c.completeError(ex);
    }

    return c.future;
  }

  @override
  Future<void>set(String ref, Map<String, dynamic> m) {
    Completer<void> c =  Completer<void>();
    try {
      Future<void> f = FirebaseFirestore.instance.doc(ref).set(m);
      f.then((_) {
        c.complete();
      }).catchError((ex) {
        c.completeError(ex);
      });
    } catch (ex) {
      c.completeError(ex);
    }

    return c.future;
  }

  @override
  Future<List<Map<String, dynamic>>> query(String ref, { String? field, dynamic value }) {
    Completer<List<Map<String, dynamic>>> c = Completer<List<Map<String, dynamic>>>();
    try {

      var fb = FirebaseFirestore.instance;
      if (field != null) {
        var f = fb.collection(ref).where(field, isEqualTo: value).get();
        f.then((q) {
          List<DocumentSnapshot<Map<String, dynamic>>> docs = q.docs;
          List<Map<String, dynamic>> results = <Map<String, dynamic>>[];
          for (var item in docs) {
            var i = item.data();
            if (i != null) {
              results.add(i);
            }
          }
          c.complete(results);
        }).onError((error, stackTrace) {
          c.completeError(error ?? 'Error in query $ref : $field : $value - no error provided');
        });
      } else {
        var f = fb.collection(ref).get();
        f.then((q) {
          List<DocumentSnapshot<Map<String, dynamic>>> docs = q.docs;
          List<Map<String, dynamic>> results = <Map<String, dynamic>>[];
          for (var item in docs) {
            var i = item.data();
            if (i != null) {
            results.add(i);
            }
            }
            c.complete(results);
          }).onError((error, stackTrace) {
          c.completeError(error ?? 'Error in query $ref - no error provided');
        });
      }
    } catch (ex) {
      c.completeError(ex);
    }
    return c.future;
  }

  @override
  Future<void> delete(String ref) {
    Completer<void> c =  Completer<void>();
    try {
      Future<void> f = FirebaseFirestore.instance.doc(ref).delete();
      f.then(( v ) {
        c.complete();
      }).catchError((ex) {
        c.completeError(ex);
      });
    } catch (ex) {
      c.completeError(ex);
    }

    return c.future;
  }

}