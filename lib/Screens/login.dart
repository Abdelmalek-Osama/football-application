import 'package:flutter/material.dart';
import 'package:flutter_lab2/Custom-widgets/bottom_navigation.dart';
import 'auth.dart';
import 'signup.dart';
import '../home_screen.dart';
import '../Custom-widgets/button.dart';
import '../Custom-widgets/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final _email = TextEditingController();
  final _password = TextEditingController();

  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text("Login",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500)),
            const SizedBox(height: 50),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
              errorText: _emailError,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              controller: _password,
              errorText: _passwordError,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            CustomButton(
              label: "Login",
              onPressed: _login,
              textColor: const Color.fromARGB(
                  255, 244, 243, 243), // Set button text color to black
            ),
            const SizedBox(height: 10),
            CustomButton(
              label: "Signin with Google",
              onPressed: () async {
                await _auth.loginWithGoogle();
              },
              textColor: const Color.fromARGB(
                  255, 248, 244, 244), // Set button text color to black
            ),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Already have an account? "),
              InkWell(
                onTap: () => goToSignup(context),
                child:
                    const Text("Signup", style: TextStyle(color: Colors.red)),
              )
            ]),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  goToHome(BuildContext context) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
      );

  Future<void> _login() async {
    String email = _email.text.trim();
    String password = _password.text.trim();

    // Reset error messages
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    // Check for empty fields
    if (email.isEmpty) {
      setState(() {
        _emailError = "Email is required.";
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        _passwordError = "Password is required.";
      });
      return;
    }

    // Validate email format
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        _emailError = "Please enter a valid email address.";
      });
      return;
    }

    try {
      // Attempt to log in the user
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the home screen or another screen after successful login
      goToHome(context);
    } catch (e) {
      String errorMessage = "Something went wrong. Please try again.";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage =
                "No user found for that email. Please check your email.";
            break;
          case 'wrong-password':
            errorMessage =
                "The password you entered is incorrect. Please try again.";
            break;
          case 'invalid-email':
            errorMessage =
                "The email format is invalid. Please check your email.";
            break;
          case 'user-disabled':
            errorMessage =
                "This user account has been disabled. Please contact support.";
            break;
          default:
            errorMessage = "Error: ${e.message}";
        }
      }
      // Show the error message in a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}
