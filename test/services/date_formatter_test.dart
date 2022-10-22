
import 'package:billiards/src/services/date_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test DateFormatter', () {
    testWidgets('When I format a date time then it works', (WidgetTester tester) async {
      var d = DateTime(2022, 11, 3, 9, 21);
      expect(formatDate(d), '3/11/2022 9:21');
    });


  });
}
