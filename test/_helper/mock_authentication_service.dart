import 'dart:async';
import 'package:billiards/authenticate.dart';


///
/// A wrapper around the Firebase Auth which creates and authenticates a user
///
class MockAuthenticationService  implements AuthenticationService {

  Set<int> userHashes = <int>{};

  MockAuthenticationService() {
    createUser('a@b.com', 'hello123');
  }

  /// Creates a user with the provided email and password.
  ///
  /// Responds with the [uid] of the newly created user.
  ///
  @override
  Future<String> createUser(String email, String password) {
    var c = Completer<String>();

    final s = '$email:$password';
    userHashes.add(s.hashCode);
    c.complete(s.hashCode.toString());

    return c.future;
  }

  /// Login with the provided email and password.
  ///
  /// Responds with the [uid] of the authenticated user.
  ///
  @override
  Future<String> login(String email, String password) {
    var c = Completer<String>();
    final s = '$email:$password';
    if (userHashes.contains(s.hashCode)) {
      c.complete(s.hashCode.toString());
    } else {
      c.completeError('Error logging in for $email');
    }

    return c.future;
  }
}
