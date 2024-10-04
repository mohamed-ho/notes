import 'package:flutter/material.dart';
import 'package:note/auth/login.dart';
import 'package:note/auth/signup.dart';
import 'package:note/home/home.dart';
import 'package:note/home/screens/add_screen.dart';
import 'package:note/home/screens/update_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'course php rest API',
      initialRoute: "login",
      routes: {
        "login": (context) => Login(),
        'signup': (context) => Signup(),
        'home': (context) => const Home(),
        'addNote': (context) => const AddScreen(),
        'updateNote': (context) => UpdateNote(),
      },
    );
  }
}
