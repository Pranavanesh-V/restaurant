import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookingSlipPage extends StatefulWidget {
  const BookingSlipPage({super.key});

  @override
  State<BookingSlipPage> createState() => _BookingSlipPageState();
}

class _BookingSlipPageState extends State<BookingSlipPage> {
  String generateEncryptedCode() {
    const String characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random random = Random();

    return List.generate(7, (index) => characters[random.nextInt(characters.length)]).join();
  }

  String u_name = "";
  bool isDataInserted = false; // Flag to prevent duplicate insertion

  Future<void> insertData(
      String uid,
      String restaurantName,
      String code,
      String guest,
      String date,
      String time,
      String specialRequest) async {
    try {
      final databaseReference = FirebaseDatabase.instance.ref().child("Users");
      DatabaseEvent event = await databaseReference.child(uid).once();
      DataSnapshot snapshot = event.snapshot;

      u_name = snapshot.child("UserName").value.toString();

      final DatabaseReference reservationRef = FirebaseDatabase.instance
          .ref("Restaurants")
          .child(restaurantName)
          .child("Reservations")
          .child("$u_name-$code");

      final DatabaseReference reservationRefUser = FirebaseDatabase.instance
          .ref("Users")
          .child(uid)
          .child("Reservations")
          .child("$restaurantName-$code");

      // Check if reservation already exists
      DatabaseEvent checkEvent = await reservationRef.once();
      if (checkEvent.snapshot.exists) {
        print("Reservation already exists!");
        return;
      }

      // Check if reservation already exists
      if (checkEvent.snapshot.exists) {
        print("Reservation already exists!");
        return;
      }

      // Insert new reservation
      await reservationRef.set({
        "Confirmation Code": code,
        "Date": date,
        "Guest": guest,
        "Guest Name": u_name,
        "Special Request": specialRequest,
        "Time": time,
      });

      //Insert new Reservation at user side
      await reservationRefUser.set({
        "Restaurant Name":restaurantName,
        "Confirmation Code": code,
        "Date": date,
        "Guest": guest,
        "Guest Name": u_name,
        "Special Request": specialRequest,
        "Time": time,
      });

      print("Data inserted successfully!");
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to reserve the table'),
          duration: Duration(seconds: 2),
          elevation: 5,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String restaurantLocation, restaurantName, code, guest, date, time, specialRequest;

    restaurantLocation = arguments['Restaurant Location'];
    restaurantName = arguments['Restaurant Name'];
    guest = arguments['Guest'];
    time = arguments['Time'];
    date = arguments['Date'];
    specialRequest = arguments['Special Request'];
    code = generateEncryptedCode();

    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;

    if (!isDataInserted && uid != null) {
      insertData(uid, restaurantName, code, guest, date, time, specialRequest);
      isDataInserted = true; // Mark data as inserted
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, "/Home");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food"),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, "/Home");
                  },
                  icon: const Icon(Icons.close, size: 30),
                ),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          titleSpacing: 50,
          titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Image.asset("assets/res_img (3).png",
                width: 360, height: 220, alignment: Alignment.center, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Reservation is confirmed",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We've sent you an email with all the details. You can also add this to your calendar",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Date & Time",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$date $time",
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Restaurant Name",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    restaurantName,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Location",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    restaurantLocation,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Confirmation Code",
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    code,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
