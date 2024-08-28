import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:restaurant/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (x){
        exit(0);
    },
      child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/logo.png",
            width: 300,
            height: 300,
            alignment: Alignment.topCenter,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Login");
                },
                child: const Text("Login",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),
                ),
              ),
              const Text("|",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black
                ),),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Sign");
                },
                child: const Text("Sign Up",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    User? user = await _authService.signInWithGoogle();
                    if (user != null) {
                      //CircularProgressIndicator();
                      Navigator.pushNamed(context, '/Home');
                      print('Sign-In Successful: ${user.uid}');
                    }
                    else
                      {
                        print("Sign in unsuccessful");
                      }
                  },
                  icon: Image.asset("assets/google.png", width: 40,),
                  color: null),
              TextButton(
                onPressed: (){
                  print("google");
                },
                child: const Text("Continue with google",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Image.asset(
                  "assets/mail.png",
                  width: 40,
                ),
              ),
              TextButton(
                onPressed: (){
                  print("mail");
                },
                child: const Text("Continue with google",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}
