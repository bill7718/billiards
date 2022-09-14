
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

///
/// A wrapper around the Firebase Auth which creates and authenticates a user
///
class AuthenticationService {

  /// The logged in user
  User? _user;

  AuthenticationService();

  /// Creates a user with the provided email and password.
  ///
  /// Responds with the [uid] of the newly created user.
  ///
  Future<String> createUser(String email, String password) {
    var c = Completer<String>();

    var auth = FirebaseAuth.instance;
    var f = auth.createUserWithEmailAndPassword(email: email, password: password);
    f.then( (response) {
      _user = response.user;
      c.complete(_user?.uid ?? '');
    }).onError((error, stackTrace) {
      c.completeError(error ?? 'Error creating a user with email $email');
    });

    return c.future;
  }

  /// Login with the provided email and password.
  ///
  /// Responds with the [uid] of the authenticated user.
  ///
  Future<String> login(String email, String password) {
    var c = Completer<String>();
    var auth = FirebaseAuth.instance;
    var f = auth.signInWithEmailAndPassword(email: email, password: password);
    f.then( (response) {
      _user = response.user;
      c.complete(_user?.uid ?? '');
    }).onError((error, stackTrace) {
      c.completeError(error ?? 'Error logging in for $email');
    });
    return c.future;
  }
}
