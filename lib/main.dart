import 'package:flutter/material.dart';
import 'package:ticktok_clone/views/screens/auth/login_screen.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,

      ),
      title: 'Ticktok Clone',
      home:  LoginScreen(),
    );
  }
}
