import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:restaurant/AuthService.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final AuthService _authService = AuthService();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();


  void google_auth() async {
    User? user = await _authService.signInWithGoogle();

    if (user != null) {
      CircularProgressIndicator();

      // Reference to the user's data in the database
      final userRef = _database.child("Users").child(user.uid);

      // Fetch the user's data from the database
      DatabaseEvent event = await userRef.once();
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        // User already exists; don't overwrite the address
        print('User already exists: ${user.uid}');
      } else {
        // User doesn't exist; set initial values
        await userRef.set({
          "Address": "-",
          "Email": user.email,
          "Phone": user.phoneNumber,
          "Profile": "No",
          "Profile value": "No",
          "UID": user.uid,
          "UserName": user.displayName,
        });
        print('New user created: ${user.uid}');
      }

      Navigator.pushNamed(context, '/Home');
      print('Sign-In Successful: ${user.uid}');
    } else {
      print("Sign in unsuccessful");
    }
  }


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
                  onPressed: ()  {
                    google_auth();
                  },
                  icon: Image.asset("assets/google.png", width: 40,),
                  color: null),
              TextButton(
                onPressed: (){
                  google_auth();
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
                onPressed: () {
                  Navigator.pushNamed(context, "/Login");
                },
                icon: Image.asset(
                  "assets/mail.png",
                  width: 40,
                ),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/Login");
                },
                child: const Text("Continue with Mail",
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
