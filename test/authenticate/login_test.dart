
import 'dart:async';

import 'package:billiards/authenticate.dart';
import 'package:billiards/beta/authenticate/login.dart';
import 'package:billiards/data.dart';
import 'package:billiards/journey.dart';
import 'package:billiards/pages.dart';
import 'package:billiards/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../_helper/mock_authentication_service.dart';
import '../_helper/mock_firebase_service.dart';
import '../_helper/mock_time_provider.dart';


void main() {

  late Login login;
  late DataService data;
  late AuthenticationService auth;
  late CurrentTimeProvider time;

  Future<void> createUser(String e, String p) async {
    var c = Completer<void>();
    var uid = await auth.createUser(e, p);
    User u = User.create(e, uid);
    await data.set(u.dbReference, u.data);
    c.complete();
    return c.future;
  }

  group('Test Login journey', () {

    setUp(() async {
      data = MockFirebaseService();
      auth = MockAuthenticationService();
      time = MockTimeProvider();
      await createUser('validuser@billiards.com', 'goodpassword');
      login = Login(auth, data, BilliardState(), time);
    });



    group('Start', () {
      testWidgets('When I start the journey I expect to be sent to the login page',
              (WidgetTester tester) async {
            var h = login.startHandler;
            expect(h.handler, login.firstPage);
            var widget = await login.firstPage();
            expect (widget is LoginPage, true);
            var page = widget as LoginPage;
            expect(page.handler.handler, login.handleLogin);
            expect(page.inputState.email, null);
            expect(page.inputState.password, null);
            expect(page.inputState.error, null);
          });
    });

    group('Events from the login page', () {
      testWidgets('When I select the home option I expect to be directed to the WelcomePage',
              (WidgetTester tester) async {

            var widget = await login.handleLogin(LoginOutputState(event: DefaultEvent.home));
            expect (widget is BilliardsWelcomePage, true);

          });

      testWidgets('When I select the back option I expect to be directed to the WelcomePage',
              (WidgetTester tester) async {

            var widget = await login.handleLogin(LoginOutputState(event: DefaultEvent.back));
            expect (widget is BilliardsWelcomePage, true);

          });

      testWidgets('When I invoke the next event but the user does not exist I expect to be directed to the LoginPage with an error',
              (WidgetTester tester) async {

            var widget = await login.handleLogin(LoginOutputState(event: DefaultEvent.next,
                email: 'doesnotexist@billiards.com', password: 'hello234'));
            expect (widget is LoginPage, true);
            var page = widget as LoginPage;
            expect(page.inputState.email, 'doesnotexist@billiards.com');
            expect(page.inputState.password, 'hello234');
            expect(page.inputState.error, Login.loginFailureMessage);

          });

      testWidgets('When I invoke the next event with a valid user but no organisation I expect to be directed to the landing page',
              (WidgetTester tester) async {

            var widget = await login.handleLogin(LoginOutputState(event: DefaultEvent.next,
                email: 'validuser@billiards.com', password: 'goodpassword'));
            expect (widget is BilliardsLandingPage, true);

            var user = login.coreState.user;
            expect(user.email, 'validuser@billiards.com');
            expect(user.lastLogin?.millisecondsSinceEpoch, MockTimeProvider.defaultTime + 1);
            expect(user.lastButOneLogin, null);
            expect(user.lastFailedLogin, null);
            expect(user.loginFailureCount, 0);

            var u2 = await data.get(user.dbReference);
            var user2 = User(data: u2);
            expect(user.email, user2.email);
            expect(user.lastLogin?.millisecondsSinceEpoch, user2.lastLogin?.millisecondsSinceEpoch);
            expect(user.lastButOneLogin, user2.lastButOneLogin);
            expect(user.lastFailedLogin, user2.lastFailedLogin);
            expect(user.loginFailureCount, user2.loginFailureCount);
            expect(user.id, user2.id);

          });
    });

  });
}