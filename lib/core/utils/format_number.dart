import 'package:intl/intl.dart';

String formatAsCurrency(
  int amount, {
  String locale = 'id_ID',
  String symbol = 'Rp',
}) {
  final value = amount;
  final formatter = NumberFormat.currency(
    locale: locale,
    symbol: symbol,
    decimalDigits: 0,
  );

  return formatter.format(value);
}

String formatAsDate(DateTime dateTime) {
  return DateFormat("dd/MM/yyyy").format(dateTime);
}
