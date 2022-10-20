
///
/// Abstracts the ability to provide the current time.
///
/// Implemented as a separate class so that tests can inject a Mock version that
/// provides a deterministic time
///
class CurrentTimeProvider {

  /// Returns the time in milliseconds since the Epoch
  int getTime()=>DateTime.now().millisecondsSinceEpoch;
}