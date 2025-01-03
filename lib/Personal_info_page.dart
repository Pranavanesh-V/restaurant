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
              child: Image.asset(
                "assets/user.png",
                width: 180,
                height: 180,
                fit: BoxFit.contain,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
