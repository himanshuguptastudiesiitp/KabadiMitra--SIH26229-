import 'package:intl/intl.dart';

String inr(num n) {
  final f = NumberFormat.currency(locale: "en_IN", symbol: "₹", decimalDigits: 0);
  return f.format(n);
}

String shortDate(DateTime d) {
  return DateFormat("d MMM, HH:mm").format(d);
}

String kmLabel(double km, [String unit = "km"]) => "${km.toStringAsFixed(1)} $unit";
