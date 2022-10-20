import 'package:billiards/src/services/organisation.dart';
import 'package:billiards/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Organisation', () {
    testWidgets('When I create an empty Organisation then it is created', (WidgetTester tester) async {
      var org = Organisation();
      expect(org.type, Organisation.objectType);
    });

    testWidgets('When I set the name I expect to be able to retrieve it', (WidgetTester tester) async {
      var org = Organisation();
      org.name = 'Hello';
      expect(org.name, 'Hello');
    });

    testWidgets('When I try to set the nmae to null I expect an exception', (WidgetTester tester) async {
      var org = Organisation();
      try {
        org.name = null;
        expect(true, false);
      } catch (ex) {
        expect(ex is DataObjectException, true);
      }
    });
  });
}
