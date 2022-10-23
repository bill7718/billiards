
import 'package:billiards/services.dart';

class MockTimeProvider implements CurrentTimeProvider {

  static const int defaultTime = 24999;

  int time;

  MockTimeProvider({this.time = defaultTime });

  @override
  int getTime() {
    time++;
    return time;
  }

  DateTime currentDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(getTime());
  }

}