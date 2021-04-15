import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:remind_me/screens/register_screen.dart';
import 'package:remind_me/screens/splash_screen.dart';
import 'package:remind_me/screens/todo_screen.dart';
import 'package:remind_me/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/todo": (context) => TodoScreen()
      },
      title: "Remind Me",
      theme: ThemeData(primarySwatch: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
