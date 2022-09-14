import 'package:flutter_test/flutter_test.dart';

import 'package:billiards/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {

    await tester.pumpWidget(const BilliardsApp());

  });

  testWidgets('test split method', (WidgetTester tester) async {

    var s = '%hello%';
    var l = s.split('%');
    expect(l.length, 3);
    expect(l.first, '');

    var s1 = 'r%hello%';
    var l1 = s1.split('%');
    expect(l1.length, 3);
    expect(l1.first, 'r');

    var s2 = 'r%%hello%';
    var l2 = s2.split('%');
    expect(l2.length, 4);
    expect(l2.first, 'r');


  });
}
