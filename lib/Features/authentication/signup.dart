import 'package:flutter/material.dart';
import 'login.dart'; // Import the LoginScreen file
import 'package:firebase_auth/firebase_auth.dart';
import '../../Screens/leagues_screen.dart'; // Firebase Authentication

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
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text("Successful registration! Redirecting to Leagues page..."),
          duration: Duration(seconds: 2),
        ),
      );

      // Navigate to the leagues page after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LeaguesScreen()),
      );
    } catch (e) {
      String errorMessage = "Something went wrong. Please try again.";
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage =
                "This email is already in use. Please use a different email.";
            break;
          case 'weak-password':
            errorMessage =
                "The password is too weak. Please use a stronger password.";
            break;
          case 'invalid-email':
            errorMessage =
                "The email format is invalid. Please check your email.";
            break;
          case 'operation-not-allowed':
            errorMessage =
                "Email/password accounts are not enabled. Please check your Firebase settings.";
            break;
          case 'user-disabled':
            errorMessage =
                "This user account has been disabled. Please contact support.";
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at the top (Replace with your actual logo path)
            Image.asset(
              'images/logo.png',  // Replace this with your logo path
              width: 150,
              height: 150,
            ),
            // Logo or App name can be placed here
            const Text(
              "Signup",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),

            // Name Field
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Name",
                labelStyle: const TextStyle(color: Colors.black),
                errorText: _nameError,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Email Field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Enter Email",
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.black),
                errorText: _emailError,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Password Field
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Enter Password",
                labelText: "Password",
                labelStyle: const TextStyle(color: Colors.black),
                errorText: _passwordError,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            // Signup Button
            ElevatedButton(
              onPressed: _signup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Signup",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Already have an account? Link to login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                InkWell(
                  onTap: () => goToLogin(context),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Go to Login screen
  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
