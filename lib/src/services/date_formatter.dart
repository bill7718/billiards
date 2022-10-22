
/// Format a DateTime to dd/mm/yyyy hh:mm
String formatDate(DateTime d) {
  final String day = d.day.toString();
  final String month = d.month.toString();
  final String year = d.year.toString();
  final String hour = d.hour.toString();
  final String minute = d.minute.toString();

  return '$day/$month/$year $hour:$minute';

}