import 'package:intl/intl.dart';

String inr(num value) {
  final f = NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 0);
  return f.format(value);
}

String shortDate(DateTime d) {
  return DateFormat('dd MMM').format(d);
}

String kmLabel(double km) {
  if (km < 1) return '${(km * 1000).round()} m';
  return '${km.toStringAsFixed(1)} km';
}
