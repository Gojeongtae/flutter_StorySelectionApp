import 'package:flutter/material.dart';
import 'package:example_7/service.dart';
import 'main.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final AuthService _authService = AuthService();

  void _handleSignIn() async {
    bool signInSuccess = await _authService.signIn();

    if (signInSuccess) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Handle login failure (e.g., show an alert dialog)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(300),
            ),
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          ),
          onPressed: _handleSignIn,
          child: Image.asset('images/google_logo.png', height: 40), // Google logo
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to Home Screen!'),
      ),
    );
  }
}