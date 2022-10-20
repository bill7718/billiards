

import 'package:billiards/src/data/data_object.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test DataObject', () {
    group ('Test instantiation', () {
      testWidgets('When I create an empty DataObject it is created',
              (WidgetTester tester) async {
            var o = TestDataObject();
            expect(o.data.isEmpty, true);

          });
    });

    group ('Test get/set', () {
      testWidgets('When I set an integer I can retrieve it later',
              (WidgetTester tester) async {
                var o = TestDataObject();
                o.set('testInteger', 42);
                expect(o.get('testInteger'), 42);
          });

      testWidgets('When I set a String I can retrieve it later',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.set('testString', '42');
            expect(o.get('testString'), '42');
          });

      testWidgets('When I set a String for an immutable DataObject I expect the immutable property to be set and I expect an exception',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.set(DataObject.immutableLabel, true);
            expect(o.immutable, true);
            try {
              o.set('testString', '42');
              expect(true, false);
            } catch(ex) {
              expect(ex is DataObjectException, true);
            }

          });

      testWidgets('When I set a value to null I expect the label top be removed',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.set('testString', '42');
            expect(o.get('testString'), '42');
            o.set('testString', null);
            expect(o.data.isEmpty, true);
          });

      testWidgets('When I set a value as a DateTime I can retrieve it later',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.setDateTime('testDateTime', DateTime(2022, 1, 12, 15 ,11));
            expect(o.getDateTime('testDateTime')?.year, 2022);
            expect(o.getDateTime('testDateTime')?.month, 1);
            expect(o.getDateTime('testDateTime')?.day, 12);
            expect(o.getDateTime('testDateTime')?.hour, 15);
            expect(o.getDateTime('testDateTime')?.minute, 11);
          });
    });

    group ('Test Notifications', ()
    {

      var notified = 0;
      notify() {
        notified++;
      }

      setUp( () {
        notified = 0;
      });

      testWidgets('When I set a value with a notification set I get the notification',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.set('testInteger', 42);
            o.addListener('testInteger', notify);
            o.set('testInteger', 43);
            expect(notified, 1);

          });

      testWidgets('When I set a value to the current value I do not expect a notification',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.set('testInteger', 42);
            o.addListener('testInteger', notify);
            o.set('testInteger', 42);
            expect(notified, 0);

          });

      testWidgets('When I set a value to null with a notification set I get the notification',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.set('testInteger', 42);
            o.addListener('testInteger', notify);
            o.set('testInteger', null);
            expect(notified, 1);

          });

      testWidgets('When I set a value to null with a notification when I then remove the notification I am no longet notified',
              (WidgetTester tester) async {
            var o = TestDataObject();
            o.set('testInteger', 42);
            o.addListener('testInteger', notify);
            o.set('testInteger', null);
            expect(notified, 1);
            o.removeListener('testInteger', notify);
            o.set('testInteger', 19);
            expect(notified, 1);

          });
    });

  });
}


class TestDataObject extends DataObject {
  TestDataObject() : super(<String, dynamic>{});

}