import 'package:billiards/authenticate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test User', () {
    testWidgets('When I create an empty User then it is created',
        (WidgetTester tester) async {
      var user = User();
      expect(user.email, null);
      expect(user.type, User.objectType);
      expect(user.lastLogin, null);
      expect(user.lastButOneLogin, null);
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

    //TODO add tests for last login date and time get and set
  });
}
