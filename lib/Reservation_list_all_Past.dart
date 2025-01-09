import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date parsing and formatting.
import 'package:firebase_database/firebase_database.dart';

class Reservation {
  final String date;
  final String guests;
  final String name;
  final DateTime reservationDateTime;

  Reservation({
    required this.date,
    required this.guests,
    required this.name,
    required this.reservationDateTime,
  });
}

class ReservationListAllPast extends StatefulWidget {
  const ReservationListAllPast({super.key, required this.uid});

  final String uid;

  @override
  State<ReservationListAllPast> createState() => _ReservationListAllPastState();
}

class _ReservationListAllPastState extends State<ReservationListAllPast> {
  late DatabaseReference _databaseRef;
  List<Reservation> _reservations = [];
  bool _isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.ref(); // Initialize database reference
    _fetchReservations();
  }

  Future<void> _fetchReservations() async {
    try {
      final snapshot = await _databaseRef
          .child("Users")
          .child('${widget.uid}/Reservations')
          .get();

      if (snapshot.exists) {
        final Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;

        setState(() {
          _reservations = data.entries
              .map((entry) {
            final Map<dynamic, dynamic> reservationData = entry.value as Map<dynamic, dynamic>;
            String dateString = reservationData['Date'] ?? 'Unknown Date'; // e.g., "Friday, January 9"
            String timeString = reservationData['Time'] ?? 'Unknown Time'; // e.g., "6:00 PM"
            DateTime? reservationDateTime;

            try {
              // Parse the date and time separately, then combine them.
              DateTime parsedDate = DateFormat('EEEE, MMMM d, yyyy').parse(dateString); // "Friday, January 9"
              DateTime parsedTime = DateFormat('h:mm a').parse(timeString); // "6:00 PM"

              // Combine date and time into a single DateTime object.
              reservationDateTime = DateTime(
                parsedDate.year,
                parsedDate.month,
                parsedDate.day,
                parsedTime.hour,
                parsedTime.minute,
              );

            } catch (e) {
              print('Error parsing date and time: $e');
            }

            // Check if the reservation date-time is in the past.
            if (reservationDateTime != null &&
                reservationDateTime.isBefore(DateTime.now())) {
              return Reservation(
                date: dateString,
                guests: reservationData['Guest'] ?? 'Unknown Guests',
                name: reservationData['Restaurant Name'] ?? 'Unknown Restaurant',
                reservationDateTime: reservationDateTime,
              );
            }
            return null;
          })
              .where((reservation) => reservation != null) // Filter out nulls.
              .cast<Reservation>() // Cast the list back to Reservation objects.
              .toList();

          // Sort reservations by date and time.
          _reservations.sort((a, b) => a.reservationDateTime.compareTo(b.reservationDateTime));
        });
      }
    } catch (e) {
      print('Error fetching reservations: $e');
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false after data fetch
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Loading indicator while fetching data
      );
    }

    // If no reservations are found, display a message
    if (_reservations.isEmpty) {
      return Center(
        child: Text(
          'No past reservations.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );
    }

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
                            Text(
                              reservation.date.split(',').length > 1
                                  ? reservation.date.split(',')[0] + ', ' + reservation.date.split(',')[1]
                                  : reservation.date,
                            ),
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
