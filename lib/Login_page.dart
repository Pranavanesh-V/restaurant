import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// Authenticate with Email/Password
  Future<void> _authenticateWithEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields");
      return;
    }

    try {
      // Try signing in with Email/Password
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _showMessage("Signed in successfully!");
      Navigator.pushNamed(context, "/Home");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // User not found; create a new account
        Navigator.popAndPushNamed(context, "/Sign");
      } else {
        _showMessage("Error: ${e.message}");
      }
    }
  }

  /// Display messages
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 50,right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 130,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login",style: TextStyle(
                  fontSize: 40
                      ,color: Colors.red
                ),),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("Email ID",
              style: TextStyle(
                  fontSize: 22
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email Address",
                  hintStyle: TextStyle(
                    color: Colors.grey
                  ),
                  prefixIcon:Icon(Icons.person),
                  label: Text("Email Id"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(100)
                      )
                  ),
                ),
                autofocus: true,
                enableIMEPersonalizedLearning: true,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Password",
              style: TextStyle(
                fontSize: 22
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextField(
                obscureText: !_isPasswordVisible, // Hide or show password text
                keyboardType: TextInputType.text,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  hintStyle: const TextStyle(
                      color: Colors.grey
                  ),
                  prefixIcon:const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  label: const Text("Password"),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(100)
                      )
                  ),
                ),
                maxLines: 1,
                enableSuggestions: true,
                enableIMEPersonalizedLearning: true,
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, "/Password_reset");
                  },
                  child: const Text("forgot password?",style: TextStyle(
                    fontSize:18,
                    color: Colors.black,
                  ),),
                ),
              ],
            ),
            const SizedBox(height: 100,),
            Center(
              child: FilledButton.icon(
                  onPressed: _authenticateWithEmail,
                  label: const Icon(Icons.arrow_right_alt_sharp),
                style: FilledButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}