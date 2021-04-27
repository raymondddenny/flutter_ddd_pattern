import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:noteapp_ddd_pattern/injection.dart';
import 'package:noteapp_ddd_pattern/presentation/core/app_widget.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(AppWidget());
}
