import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Transfer Tracker',
      theme: ThemeData(
        primaryColor: Color(0xFF0A2647),
        scaffoldBackgroundColor: Color(0xFF144272),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF0A2647),
          secondary: Color(0xFF2C74B3),
        ),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFF205295)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0A2647)),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
