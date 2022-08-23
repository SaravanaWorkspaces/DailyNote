import 'dart:async';

import 'package:flutter/material.dart';
import 'package:daily_note/locator.dart' as get_it;
import 'app.dart';

void main() {
  unawaited(get_it.init());
  runApp(const App());
}
