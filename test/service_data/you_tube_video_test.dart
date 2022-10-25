import 'package:billiards/data.dart';
import 'package:billiards/service_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Test You Tube Video', () {
    testWidgets('When I create an empty Youtube Video then it is created', (WidgetTester tester) async {
      var yt = YouTubeVideo('A/12345');
      expect(yt.type, YouTubeVideo.objectType);
      expect(yt.get(EmbeddedPersistableDataObject.parentDBRefLabel), 'A/12345');
      expect(yt.data.length, 2);
    });

    testWidgets('When I create a Youtube Video from values then it is created', (WidgetTester tester) async {
      var yt = YouTubeVideo.fromValues('A/12345', 'ytname', 'ytvideoid');
      expect(yt.type, YouTubeVideo.objectType);
      expect(yt.get(EmbeddedPersistableDataObject.parentDBRefLabel), 'A/12345');
      expect(yt.get(YouTubeVideo.nameLabel), 'ytname');
      expect(yt.get(YouTubeVideo.videoIdLabel), 'ytvideoid');
    });

    testWidgets('When I create a Youtube Video from a map then it is created', (WidgetTester tester) async {
      var yt = YouTubeVideo.fromValues('A/12345', 'ytname', 'ytvideoid');

      var yt2 = YouTubeVideo('A/12345', data: yt.data);

      expect(yt.id, yt2.id);
      expect(yt.get(YouTubeVideo.nameLabel), yt2.get(YouTubeVideo.nameLabel));
    });
  });
}
