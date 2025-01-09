import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Reservation {

  final String date;
  final String guests;
  final String name;

  Reservation({required this.date, required this.guests,required this.name});
}

class ReservationList extends StatefulWidget {
  const ReservationList({super.key, required this.uid,required this.res_name});

  final String uid;
  final String res_name;

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {
  late DatabaseReference _databaseRef;
  List<Reservation> _reservations = [];

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.ref(); // Initialize database reference
    _fetchReservations(widget.res_name);
  }

  Future<void> _fetchReservations(String restaurantName) async {
    try {
      // Access all reservations under the uid
      final snapshot = await _databaseRef
          .child("Users")
          .child(widget.uid)
          .child("Reservations")
          .get();

      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          // Filter reservations that match the restaurant name in the key
          _reservations = data.entries
              .where((entry) => (entry.key as String).contains(restaurantName))
              .map((entry) {
            final Map<dynamic, dynamic> reservationData = entry.value as Map<dynamic, dynamic>;
            return Reservation(
              date: reservationData['Date'] ?? 'Unknown Date',
              guests: reservationData['Guest'] ?? 'Unknown Guests',
              name: reservationData['Restaurant Name'] ?? 'Unknown Restaurant',
            );
          }).toList();
        });
      } else {
        print("No reservations found.");
      }
    } catch (e) {
      print('Error fetching reservations: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _reservations.length,
      itemBuilder: (BuildContext context, int index) {
        final reservation = _reservations[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/Reservation_detail", arguments: reservation);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Card(
              elevation: 5,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/past_dates.png", width: 80, height: 80),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              reservation.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(reservation.date.split(',')[0] + ', ' + reservation.date.split(',')[1]),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text('${reservation.guests} Guests'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
