import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordResetLinkPage extends StatefulWidget {
  const PasswordResetLinkPage({super.key});

  @override
  State<PasswordResetLinkPage> createState() => _PasswordResetLinkPageState();
}

class _PasswordResetLinkPageState extends State<PasswordResetLinkPage> {

  String EmailID="";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _sendPasswordResetEmail(String email) async {

    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent!')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Change password",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15,),
            Text("Your password must be at least 6 characters and should be included a combination of number,letters and special charcters(!\$@#",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 150,),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Email ID"),
                    ),
                    Container(
                      width: 500, // Set the width
                      height: 60, // Set the height
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Set the border color
                          width: 2.0, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(10.0), // Optional: Set border radius
                      ),
                      child: Center(
                        child: TextField(
                          onSubmitted: (x){
                            EmailID=x.trim();
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Remove the underline border
                            enabledBorder: InputBorder.none, // Ensure no border when enabled
                            focusedBorder: InputBorder.none,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16.0, // Optional: Set text size
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 50,),
            Center(
                child: ElevatedButton(
                  onPressed: () {
                    _sendPasswordResetEmail(EmailID);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min, // Make the button only as wide as its content
                    children: [
                      Text('Change password'),
                      SizedBox(width: 8), // Add some spacing between text and icon
                      Icon(Icons.send), // Icon at the end
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
