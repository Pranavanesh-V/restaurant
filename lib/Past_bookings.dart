import 'package:flutter/material.dart';
import 'Reservation_list_all_Past.dart';

class PastBookings extends StatefulWidget {
  const PastBookings({super.key});

  @override
  State<PastBookings> createState() => _PastBookingsState();
}

class _PastBookingsState extends State<PastBookings> {

  late String uid; // Variable to store passed data

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve data passed from the previous page
    uid = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text("Past Reservations",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 25.0),
            child: SizedBox(
              height: 605,
              child: ReservationListAllPast(uid: uid),
            ),
          ),
        ],
      ),
    );
  }
}
