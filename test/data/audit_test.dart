
import 'package:billiards/src/data/audit.dart';
import 'package:billiards/data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Audit', () {
    group ('Test instantiation', () {
      testWidgets('When I create an empty Audit record from values it is created correctly',
              (WidgetTester tester) async {
            var now = DateTime.now().millisecondsSinceEpoch;
            var o = Audit.fromValues('Parent/123', 'Test');
            expect(o.data.length, 4, reason: o.data.toString());
            expect(o.get(Audit.auditEventLabel), 'Test');
            expect(o.dbReference.contains('Parent/123/Audit'), true);
            expect(o.get(PersistableDataObject.createdLabel) >= now, true);
            expect(o.get(PersistableDataObject.createdLabel) <= now + 5, true);

          });

      testWidgets('When I create an Audit record with data from values it is created correctly',
              (WidgetTester tester) async {
            var now = DateTime.now().millisecondsSinceEpoch;
            var o = Audit.fromValues('Parent/123', 'Test', auditData: { 'hello' : 123} );
            expect(o.data.length, 5, reason: o.data.toString());
            expect(o.get(Audit.auditEventLabel), 'Test');
            expect(o.dbReference.contains('Parent/123/Audit'), true);
            expect(o.get(PersistableDataObject.createdLabel) >= now, true);
            expect(o.get(PersistableDataObject.createdLabel) <= now + 5, true);

            expect (o.get('hello'), 123);

          });
    });


  });
}

