import 'package:billiards/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Current time provider', () {
    testWidgets('When I ask for the current time then it is provided', (WidgetTester tester) async {
      var time = CurrentTimeProvider();
      var t = DateTime.now().millisecondsSinceEpoch;
      expect(time.getTime() >= t, true);
      expect(time.getTime() <= t + 5, true);
    });


  });
}
