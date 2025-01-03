import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Reservation_list.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String uid = user!.uid;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
                child: Text("Reservations",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 10.0),
            child: SizedBox(
              height: 620,
              child: ReservationList(uid: uid,),
            ),
          ),
        ],
      ),
    );
  }
}
