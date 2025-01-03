import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/AuthService.dart';

class Profile extends StatefulWidget {

  String data = "Loading...";
  String uid="";

  Profile(String uid, {super.key})
  {
    this.uid = uid;
    print(uid);
  }

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _authService = AuthService();

  final databaseReference = FirebaseDatabase.instance.ref().child("Users");

  @override
  void initState() {
    super.initState();
    fetchData(widget.uid);
  }

  void show() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black12,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                  Navigator.pushNamed(context, "/Security"); // Navigate to Security page
                },
                child: const Text(
                  "Security",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                  Navigator.pushNamed(context, "/About");
                },
                child: const Text(
                  "About",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  _authService.signOut(); // Sign out the user
                  Navigator.of(context).pop(); // Dismiss the dialog
                  Navigator.pushReplacementNamed(context, '/Landing'); // Navigate to Landing page
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showProfile() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black12,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100, // Set radius to half of the desired size (500/2)
                  backgroundColor: Colors.transparent, // Optional background color
                  child: ClipOval(
                    child: Image.asset(
                      "assets/user.png",
                      width: 250,
                      height: 250,
                      fit: BoxFit.cover, // Ensures the image fills the circular container
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  Future<void> fetchData(String uid) async {
    try {
      DatabaseEvent event = await databaseReference.child(uid).once();
      DataSnapshot snapshot = event.snapshot;

      setState(() {
        widget.data = snapshot.child("UserName").value.toString();
      });
    } catch (error) {
      setState(() {
        widget.data = "Error fetching data: $error";
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    showProfile();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                        "assets/user.png",width: 70,height: 70,fit: BoxFit.contain,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.data,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            const Text("show profile",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){
                      show();
                    },
                    icon: const Icon(Icons.settings)
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text("Reservation",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/Upcoming",arguments: widget.uid);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset("assets/past_dates.png",width: 50,height: 50,),
                  const Text("Upcoming",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 150,),
                  const Icon(Icons.arrow_forward_ios,size: 25),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/Past",arguments: widget.uid);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset("assets/past_dates.png",width: 50,height: 50,),
                  const Text("Past",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 190,),
                  const Icon(Icons.arrow_forward_ios,size: 25),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Text("Account Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/Personal",arguments: {"uid":widget.uid});
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset("assets/show profile.png",width: 50,height: 50,),
                  const Text("Personal Information",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 60,),
                  const Icon(Icons.arrow_forward_ios,size: 25),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, "/Password");
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset("assets/password_.png",width: 50,height: 50,),
                  const Text("Password",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 140,),
                  const Icon(Icons.arrow_forward_ios,size: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
