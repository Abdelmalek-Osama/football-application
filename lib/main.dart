import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCeygKsvPBxBOT2RIRBU-w96TlFlbTSewM",
        authDomain: "football-2f1ec.firebaseapp.com",
        projectId: "football-2f1ec",
        storageBucket: "football-2f1ec.appspot.com",
        messagingSenderId: "415971478282",
        appId: "1:415971478282:web:1459adbb669ae5666708f3",
      ),
    );
    print("Firebase Initialized Successfully!");
  } catch (e) {
    print("Firebase Initialization Failed: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Transfer Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
