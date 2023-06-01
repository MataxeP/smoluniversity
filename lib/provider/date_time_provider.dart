import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final dateProvider = StateProvider<String>((ref) {
  return DateFormat("dd/M/yyyy").format(DateTime.now());
});

final timeProvider = StateProvider<String>((ref) {
  return DateFormat('yyyy-M-dd HH:mm:s.S').format(DateTime.now());
});

final endTimeProvider = StateProvider<String>((ref) {
  return DateFormat('yyyy-M-dd HH:mm:s.S').format(DateTime.now());
});
