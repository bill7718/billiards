import 'package:billiards/data.dart';
import 'package:billiards/service_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test Liturgy', () {
    testWidgets('When I create an empty Liturgy then it is created', (WidgetTester tester) async {
      var liturgy = Liturgy('A/12345');
      expect(liturgy.type, Liturgy.objectType);
      expect(liturgy.get(EmbeddedPersistableDataObject.parentDBRefLabel), 'A/12345');
      expect(liturgy.data.length, 2);
    });

    testWidgets('When I create a Liturgy Video from values then it is created', (WidgetTester tester) async {
      var liturgy = Liturgy.fromValues('A/12345', 'litname', 'litcontent');
      expect(liturgy.type, Liturgy.objectType);
      expect(liturgy.get(EmbeddedPersistableDataObject.parentDBRefLabel), 'A/12345');
      expect(liturgy.get(Liturgy.nameLabel), 'litname');
      expect(liturgy.get(Liturgy.textLabel), 'litcontent');
    });

    testWidgets('When I create a Liturgy from a map then it is created', (WidgetTester tester) async {
      var liturgy1 = Liturgy.fromValues('A/12345', 'litname', 'litcontent');

      var liturgy2 = Liturgy('A/12345', data: liturgy1.data);

      expect(liturgy1.id, liturgy2.id);
      expect(liturgy1.get(Liturgy.nameLabel), liturgy2.get(Liturgy.nameLabel));
    });
  });
}
