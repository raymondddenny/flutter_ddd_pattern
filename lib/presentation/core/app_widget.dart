import 'package:flutter/material.dart';
import 'package:noteapp_ddd_pattern/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      home: SignInPage(),
      theme: ThemeData.light().copyWith(
          primaryColor: Colors.yellow[800],
          accentColor: Colors.blueAccent,
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          )),
    );
  }
}
