///
/// Handles authentication. Specifically it
/// - creates new users
/// - authenticates existing users
/// - allows an existing user to 'invite' a new user to join the same organisation
///
library authenticate;

export 'src/authentication/authentication_service.dart';

export 'src/authentication/user.dart';

export 'src/authentication/login_page.dart';
export 'src/authentication/capture_email_page.dart';