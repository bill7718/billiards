
import 'package:billiards/data.dart';

/// Data for a You tube video
class YouTubeVideo extends EmbeddedPersistableDataObject {

  static const String objectType = 'YouTubeVideo';

  static const String nameLabel = 'name';
  static const String videoIdLabel = 'videoId';


  YouTubeVideo(String parentDBRef, {Map<String, dynamic>? data }) : super(objectType, parentDBRef, data: data);

  YouTubeVideo.fromValues(String parentDBRef, String name, String videoId ) : super(objectType, parentDBRef) {
    set(nameLabel, name);
    set(videoIdLabel, videoId);
  }

}