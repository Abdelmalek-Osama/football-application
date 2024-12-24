import 'dart:developer';

import 'package:flutter/material.dart';
import '../home_screen.dart';
import '../Custom-widgets/button.dart';
import '../Custom-widgets/textfield.dart';
import 'auth.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';  // Add this import

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Reset error messages
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
    });

    // Check for empty fields
    if (name.isEmpty) {
      setState(() {
        _nameError = "Name is required.";
      });
    }

    if (email.isEmpty) {
      setState(() {
        _emailError = "Email is required.";
      });
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = "Password is required.";
      });
    }

    // If there are any errors, return early
    if (_nameError != null || _emailError != null || _passwordError != null) {
      return;
    }

    // Validate email format
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        _emailError = "Please enter a valid email address.";
      });
      return;
    }

    // Validate password strength
    if (password.length < 6) {
      setState(() {
        _passwordError = "Password must be at least 6 characters long.";
      });
      return;
    }

    try {
      // Attempt to create a new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successful registration!"),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to the home screen or another screen after successful signup
      goToLogin(context);
    } catch (e) {
      String errorMessage = "Something went wrong. Please try again.";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = "This email is already in use. Please use a different email.";
            break;
          case 'weak-password':
            errorMessage = "The password is too weak. Please use a stronger password.";
            break;
          case 'invalid-email':
            errorMessage = "The email format is invalid. Please check your email.";
            break;
          case 'operation-not-allowed':
            errorMessage = "Email/password accounts are not enabled. Please check your Firebase settings.";
            break;
          case 'user-disabled':
            errorMessage = "This user account has been disabled. Please contact support.";
            break;
          default:
            errorMessage = "Error: ${e.message}";
        }
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text("Signup", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(height: 50),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Name",
                errorText: _nameError, // Show error message if exists
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter Email",
                labelText: "Email",
                errorText: _emailError, // Show error message if exists
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: "Enter Password",
                labelText: "Password",
                errorText: _passwordError, // Show error message if exists
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _signup,
              child: const Text("Signup"),
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => goToLogin(context),
                child: const Text("Login", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  void goToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }
}