import 'package:intl/intl.dart';

class HumansFormat {
  static String number(double number) {
    final formatterNumber =
      NumberFormat.compactCurrency(decimalDigits: 0, symbol: '', locale: 'en')
        .format(number);

    return formatterNumber;
  }

  static String porcentage(double number) {
    final formattedNumber =
      NumberFormat("###.#", "en_US")
        .format(number);
    return formattedNumber;
  }
}
