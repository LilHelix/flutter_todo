import 'package:intl/intl.dart';

class DateUtils {

  static const String HUMAN_READABLE_DATE_FORMAT = 'HH:mm, MMMM dd\'st\', yyyy';

  static String formatDate(String template, DateTime date) {
    return DateFormat(template).format(date);
  }

  static String reformatDateToReadable(DateTime date) {
    return formatDate(HUMAN_READABLE_DATE_FORMAT, date);
  }

}