import 'package:flutter/material.dart';
import 'Reservation_list_all_.dart';

class UpcomingBookings extends StatefulWidget {
  const UpcomingBookings({Key? key}) : super(key: key);

  @override
  State<UpcomingBookings> createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
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
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Center(
              child: Text(
                "Upcoming Reservations",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
            child: SizedBox(
              height: 605,
              child: ReservationListAll(
                uid: uid, // Pass the retrieved data to ReservationList
              ),
            ),
          ),
        ],
      ),
    );
  }
}
