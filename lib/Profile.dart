import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/AuthService.dart';
import 'package:restaurant/ProfilePopup.dart';

class Profile extends StatefulWidget {
  String data = "Loading..."; // User name
  String uid = ""; // User ID

  Profile(this.uid, {super.key}) {
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

  // Show the settings dialog.
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

  // Show profile dialog.
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
                      "assets/user.png", // Default image
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

  // Fetch user data from Firebase Realtime Database.
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

  // Fetch the profile image URL from Firebase Database.
  Future<String?> fetchImageUrl(String uid) async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child("Users")
          .child(uid)
          .child("Profile value");

      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        String imageUrl = snapshot.value.toString();
        print(imageUrl);
        if(imageUrl!="No") {
          return imageUrl; // Return the URL if found.
        }
        else{
          return null;
        }
      } else {
        print("No image URL found in the database.");
        return null; // Return null if no URL is present.
      }
    } catch (e) {
      print("Error fetching image URL: $e");
      return null; // Return null in case of an error.
    }
  }

  // Display profile popup when clicked.
  void showProfilePopup() async {
    String? currentImageUrl = await fetchImageUrl(widget.uid);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfilePopup(
          username: widget.data,
          uid:widget.uid,
          currentImageUrl: currentImageUrl, // Pass the current image URL.
          onImageUpdated: (newUrl) {
            print('Image updated: $newUrl');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: showProfilePopup,
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: FutureBuilder<String?>(
                          future: fetchImageUrl(widget.uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasData && snapshot.data != null) {
                              return ClipOval(
                                child: Image.network(
                                  snapshot.data!,  // The image URL
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.fitWidth,
                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                    // If the image is still loading, show a loading spinner
                                    if (loadingProgress == null) {
                                      return child; // If the image is loaded, display the image
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                              : null, // Show progress if available
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            } else {
                              return Image.asset(
                                "assets/user.png",
                                width: 70,
                                height: 70,
                                fit: BoxFit.contain,
                              );
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data,
                              style: const TextStyle(fontSize: 22),
                            ),
                            const Text(
                              "show profile",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: show,
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              "Reservation",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
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