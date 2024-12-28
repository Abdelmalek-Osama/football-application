import 'package:flutter/material.dart';
import 'package:flutter_lab2/Custom-widgets/bottom_navigation.dart';
import 'auth_service.dart';
import 'signup.dart';
import '../../Custom-widgets/button.dart';
import '../../Custom-widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Logo at the top (Replace with your actual logo path)
            Image.asset(
              'images/logo.png',  // Replace this with your logo path
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 40),
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            CustomTextField(
              controller: _emailController,
              label: "Email",
              hint: "Enter your email",
              errorText: _emailError,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: _passwordController,
              label: "Password",
              hint: "Enter your password",
              errorText: _passwordError,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            // Modern Login button with gradient effect
            CustomButton(
              label: "Login",
              onPressed: _login,
              textColor: Colors.white,
              backgroundColor: Colors.blueAccent,
            ),
            const SizedBox(height: 15),
            // Sign in with Google button
            CustomButton(
              label: "Sign in with Google",
              onPressed: _auth.loginWithGoogle,
              textColor: Colors.black,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                InkWell(
                  onTap: () => _goToSignup(context),
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _goToSignup(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

void _goToHome(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const BottomNavigation()),
    (route) => false, // This removes all previous routes (including the login screen)
  );
}

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Reset error messages
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Validate form fields
    if (email.isEmpty) {
      setState(() => _emailError = "Email is required.");
      return;
    }

    if (password.isEmpty) {
      setState(() => _passwordError = "Password is required.");
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() => _emailError = "Please enter a valid email address.");
      return;
    }

    try {
      // Attempt login
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      _goToHome(context);
    } catch (e) {
      String errorMessage = "Something went wrong. Please try again.";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "No user found for that email.";
            break;
          case 'wrong-password':
            errorMessage = "Incorrect password. Please try again.";
            break;
          case 'invalid-email':
            errorMessage = "The email format is invalid.";
            break;
          case 'user-disabled':
            errorMessage = "This account has been disabled.";
            break;
          default:
            errorMessage = e.message ?? "An error occurred.";
        }
      }

      // Show error message in a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
