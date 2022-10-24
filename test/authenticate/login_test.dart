
import 'dart:async';

import 'package:billiards/authenticate.dart';
import 'package:billiards/src/authentication/login.dart';
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

  Future<User> createUser(String e, String p) async {
    var c = Completer<User>();
    var uid = await auth.createUser(e, p);
    User u = User.create(e, uid);
    await data.set(u.dbReference, u.data);
    c.complete(u);
    return c.future;
  }

  group('Test Login journey', () {

    setUp(() async {
      data = MockFirebaseService();
      auth = MockAuthenticationService();
      time = MockTimeProvider();
      await createUser('validuser@billiards.com', 'goodpassword');

      // used to test a user linked to one organisation
      var u1 = await createUser('oneorg@billiards.com', 'goodpassword');
      var org1 = Organisation();
      org1.name = 'One Org Name';
      await data.set(org1.dbReference, org1.data);

      var u1o1 = DataObjectRelationship.data(from: u1, to: org1, type: User.userToOrganisation);
      await data.set(u1o1.dbReference, u1o1.data);

      // used to test a user linked to two organisations
      var u2 =  await createUser('twoorg@billiards.com', 'goodpassword');

      var org2 = Organisation();
      org2.name = 'Two Org Name #1';
      await data.set(org2.dbReference, org2.data);

      var u2o21 = DataObjectRelationship.data(from: u2, to: org2, type: User.userToOrganisation);
      await data.set(u2o21.dbReference, u2o21.data);

      var org3 = Organisation();
      org3.name = 'Two Org Name #2';
      await data.set(org3.dbReference, org3.data);

      var u2o22 = DataObjectRelationship.data(from: u2, to: org3, type: User.userToOrganisation);
      await data.set(u2o22.dbReference, u2o22.data);



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
            var page = widget as BilliardsLandingPage;
            expect (page.message, null);

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

            var map = user2.get('Audit');
            expect(map?.length, 1);
            Audit audit = Audit.fromMap(map.values.first);
            expect(audit.event, Login.auditSuccess);

            expect(login.coreState.organisation, null);

          });


      testWidgets('When I invoke the next event with a valid user in one organisation I expect to be directed to the landing page with the organisation set in the core state',
              (WidgetTester tester) async {

            var widget = await login.handleLogin(LoginOutputState(event: DefaultEvent.next,
                email: 'oneorg@billiards.com', password: 'goodpassword'));
            expect (widget is BilliardsLandingPage, true);
            var page = widget as BilliardsLandingPage;
            expect (page.message, null);

            var user = login.coreState.user;
            expect(user.email, 'oneorg@billiards.com');
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

            var map = user2.get('Audit');
            expect(map?.length, 1);
            Audit audit = Audit.fromMap(map.values.first);
            expect(audit.event, Login.auditSuccess);

            var org = login.coreState.organisation;
            expect(org?.name, 'One Org Name');

          });

      testWidgets('When I invoke the next event with a valid user but two organisations I expect to be directed to the landing page',
              (WidgetTester tester) async {

            var widget = await login.handleLogin(LoginOutputState(event: DefaultEvent.next,
                email: 'twoorg@billiards.com', password: 'goodpassword'));
            expect (widget is BilliardsLandingPage, true);
            var page = widget as BilliardsLandingPage;
            expect (page.message, null);

            var user = login.coreState.user;
            expect(user.email, 'twoorg@billiards.com');
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

            var map = user2.get('Audit');
            expect(map?.length, 1);
            Audit audit = Audit.fromMap(map.values.first);
            expect(audit.event, Login.auditSuccess);

            expect(login.coreState.organisation, null);

          });
    });

  });
}