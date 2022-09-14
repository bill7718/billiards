///
/// Handles authentication. Specifically it
/// - creates new users
/// - authenticates existing users
/// - allows an existing user to 'invite' a new user to join the same organisation
///
library authenticate;

export 'src/authentication/authentication_service.dart';

export 'beta/authenticate/invite_user.dart';
export 'beta/authenticate/login.dart';
export 'beta/authenticate/register_user.dart';

export 'src/authentication/capture_email_page.dart';
export 'beta/authenticate/capture_organisation_page.dart';
export 'beta/authenticate/capture_password_page.dart';
export 'beta/authenticate/confirm_organisation_page.dart';
export 'beta/authenticate/login_page.dart';
export 'beta/authenticate/invite_user_page.dart';

export 'beta/authenticate/invited_user.dart';
export 'src/authentication/user.dart';