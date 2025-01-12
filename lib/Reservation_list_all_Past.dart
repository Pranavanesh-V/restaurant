import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';

class Reservation {
  final String date;
  final String guests;
  final String name;
  final DateTime reservationDateTime;
  final String confirmationCode;
  final String time;

  Reservation({
    required this.date,
    required this.guests,
    required this.name,
    required this.reservationDateTime,
    required this.confirmationCode,
    required this.time,
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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.ref();
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
        _reservations = data.entries
            .map((entry) {
          final reservationData = entry.value as Map<dynamic, dynamic>;
          String dateString = reservationData['Date'] ?? 'Unknown Date';
          String timeString = reservationData['Time'] ?? 'Unknown Time';
          DateTime? reservationDateTime;

          try {
            // Clean date and time strings to remove non-breaking spaces or extra spaces
            dateString = dateString.replaceAll('\u202F', ' ').trim();
            timeString = timeString.replaceAll('\u202F', ' ').trim();

            // Parse date and time separately, then combine them.
            DateTime parsedDate = DateFormat('EEEE, MMMM d, yyyy').parse(dateString);
            DateTime parsedTime = DateFormat('h:mm a').parse(timeString);

            reservationDateTime = DateTime(
              parsedDate.year,
              parsedDate.month,
              parsedDate.day,
              parsedTime.hour,
              parsedTime.minute,
            );

            print(reservationDateTime);
            print(DateTime.now());
            if (reservationDateTime.isBefore(DateTime.now())) {
              return Reservation(
                date: dateString,
                guests: reservationData['Guest'] ?? 'Unknown Guests',
                name: reservationData['Restaurant Name'] ?? 'Unknown Restaurant',
                reservationDateTime: reservationDateTime,
                confirmationCode: reservationData['Confirmation Code'] ?? 'Unknown Code',
                time: reservationData['Time'],
              );
            }
          } catch (e) {
            print('Skipping invalid reservation: $e');
          }
          return null;
        })
            .where((reservation) => reservation != null)
            .cast<Reservation>()
            .toList();

        _reservations.sort((a, b) => a.reservationDateTime.compareTo(b.reservationDateTime));
      }
    } catch (e) {
      print('Error fetching reservations: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_reservations.isEmpty) {
      return const Center(child: Text('No past reservations.',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
    }

    return ListView.builder(
      itemCount: _reservations.length,
      itemBuilder: (BuildContext context, int index) {
        final reservation = _reservations[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/Reservation_detail", arguments: {"res name":reservation.name,"res_date":reservation.date,"res_time":reservation.time,"res_code":reservation.confirmationCode,"notify":false});
          },
          child: Card(
            elevation: 5,
            child: ListTile(
              leading: Image.asset("assets/past_dates.png"),
              title: Text(reservation.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(reservation.date),
              trailing: Text('${reservation.guests} Guests'),
            ),
          ),
        );
      },
    );
  }
}
