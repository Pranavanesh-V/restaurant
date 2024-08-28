import 'package:flutter/material.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
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
            Text("Password and security",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15,),
            Text("Login & recovery",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height:10,),
            Text("Manage your passwords,change your passwords at your will...",
              style: TextStyle(
                  fontSize: 15,
              ),
            ),
            SizedBox(height: 200,),
            Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/Password_reset"); // Action when button is pressed
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
