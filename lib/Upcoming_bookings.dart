import 'package:flutter/material.dart';
import 'Reservation_list.dart';

class UpcomingBookings extends StatefulWidget {
  const UpcomingBookings({super.key});

  @override
  State<UpcomingBookings> createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
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
        body: const Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text("Upcoming Reservations",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0,right: 15.0,top: 25.0),
              child: SizedBox(
                height: 605,
                child: ReservationList(),
              ),
            ),
          ],
        ),
      );
  }
}
