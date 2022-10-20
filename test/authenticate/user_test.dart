import 'package:billiards/authenticate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test User', () {
    testWidgets('When I create an empty User then it is created',
        (WidgetTester tester) async {
      var user = User();
      expect(user.type, User.objectType);
      expect(user.lastLogin, null);
      expect(user.lastButOneLogin, null);
      expect(user.lastFailedLogin, null);
      expect(user.loginFailureCount, 0);
    });

    testWidgets('When I create a User from values then it is created',
        (WidgetTester tester) async {
      var user = User.create('a@b.com', 'abc123');
      expect(user.email, 'a@b.com');
      expect(user.userId, 'abc123');
      expect(user.lastLogin, null);
      expect(user.lastButOneLogin, null);
      expect(user.type, User.objectType);
    });

    testWidgets('When I create a User from a map then it is created',
        (WidgetTester tester) async {
      var user1 = User.create('a@b.com', 'abc123');

      var user2 = User(data: user1.data);

      expect(user1.id, user2.id);
      expect(user1.email, user2.email);
    });

    testWidgets('When I try to get email from an empty User then I expect an exception',
            (WidgetTester tester) async {
          var user = User();
          try {
            var e = user.email;
            expect(true, false);
          } catch (ex) {
            expect (ex is UserException, true);
          }

        });

    testWidgets('When I try to get a userId from an empty User then I expect an exception',
            (WidgetTester tester) async {
          var user = User();
          try {
            var i = user.userId;
            expect(true, false);
          } catch (ex) {
            expect (ex is UserException, true);
          }

        });

    testWidgets('When I set the lastLoginDateTime I expect the last but one loginDateTime to also  be updated',
            (WidgetTester tester) async {
          var user = User();
          user.setLoginDateTime(DateTime(2022, 1, 12, 15 ,11));
          expect(user.lastLogin?.minute, 11);
          expect(user.lastButOneLogin, null);

          user.setLoginDateTime(DateTime(2022, 1, 12, 15 ,27));
          expect(user.lastLogin?.minute, 27);
          expect(user.lastButOneLogin?.minute, 11);

        });

    testWidgets('When I set the lastFailedLogin I expect to be able to retrieve it',
            (WidgetTester tester) async {
          var user = User();
          user.setDateTime(User.lastFailedLoginLabel, DateTime(2022, 1, 12, 15 ,11));
          expect(user.lastFailedLogin?.minute, 11);

        });
  });
}
