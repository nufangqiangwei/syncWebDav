import 'dart:html';

import 'package:logger/logger.dart';
import 'package:logger/src/outputs/file_output.dart';

class Log {
  late File logFile;
  Logger _logger = Logger();

   void v(dynamic message) {
    _logger.v(message);
  }

   void d(dynamic message) {
    _logger.d(message);
  }

   void i(dynamic message) {
    _logger.i(message);
  }

   void w(dynamic message) {
    _logger.w(message);
  }

   void e(dynamic message) {
    _logger.e(message);
  }

   void wtf(dynamic message) {
    _logger.wtf(message);
  }
}