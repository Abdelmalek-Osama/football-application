import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Features/authentication/login.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fanzawy',
      theme: ThemeData(
        primaryColor: kBackgroundColor,
        scaffoldBackgroundColor: appBarBackgroundColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kBackgroundColor,
          secondary: Color(0xFF2C74B3),
        ),
        appBarTheme: AppBarTheme(backgroundColor: cardBackgroundColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: kBackgroundColor),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
