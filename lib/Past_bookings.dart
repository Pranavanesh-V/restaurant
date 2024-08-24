import 'package:flutter/material.dart';

class PastBookings extends StatefulWidget {
  const PastBookings({super.key});

  @override
  State<PastBookings> createState() => _PastBookingsState();
}

class _PastBookingsState extends State<PastBookings> {

  Widget Reservation_list_item() {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int x) {
          return Padding(
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
                      Image.asset(
                        "assets/past_dates.png", width: 80, height: 80,),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(child: Text("Hidden Gem", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),)),
                            Text("August 14,8:52 pm"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 50,),
                      const Text("4 Guest"),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
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
          Padding(
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
            padding: EdgeInsets.only(left: 15.0,right: 15.0,top: 25.0),
            child: SizedBox(
              height: 605,
              child: Reservation_list_item(),
            ),
          ),
        ],
      ),
    );
  }
}
