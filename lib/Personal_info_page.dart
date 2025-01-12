import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  String userName = "Loading...";
  String email = "Loading...";
  String phone = "Loading...";
  String address = "Loading...";
  bool isDataFetched = false; // Add a flag to track data fetching

  // Function to fetch data from Firebase
  Future<void> fetchUserData(String userId) async {
    try {
      final DatabaseReference databaseRef =
      FirebaseDatabase.instance.ref().child("Users").child(userId);

      // Fetch data once
      DatabaseEvent event = await databaseRef.once();

      // Extract data from the snapshot
      DataSnapshot snapshot = event.snapshot;
      setState(() {
        userName = snapshot.child("UserName").value?.toString() ?? "No Name";
        email = snapshot.child("Email").value?.toString() ?? "No Email";
        phone = snapshot.child("Phone").value?.toString() ?? "No Phone";
        address = snapshot.child("Address").value?.toString() ?? "No Address";
      });

      print("User Name: $userName");
      print("Email: $email");
      print("Phone: $phone");
      print("Address: $address");
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch user data once when dependencies change
    if (!isDataFetched) {
      final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      String uid = arguments["uid"];
      fetchUserData(uid);
      isDataFetched = true; // Set the flag to true
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String uid = arguments["uid"];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(fontSize: 25, color: Colors.black),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/Edit",arguments: {"uid":uid,"name":userName,"address":address,"phone":phone,"email":email});
            },
            child: const Text(
              "Edit",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 90,
              minRadius: 90,
              child: FutureBuilder<String?>(
                future: fetchImageUrl(uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return ClipOval(
                      child: Image.network(
                        snapshot.data!,  // The image URL
                        width: 180,
                        height: 180,
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
                      width: 180,
                      height: 180,
                      fit: BoxFit.contain,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 10),
            infoCard("Name", userName),
            infoCard("Address", address, height: 120),
            infoCard("Phone", phone),
            infoCard("Email", email),
          ],
        ),
      ),
    );
  }

  Widget infoCard(String label, String value, {double height = 60}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(label),
          ),
          Container(
            width: 500,
            height: height,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
