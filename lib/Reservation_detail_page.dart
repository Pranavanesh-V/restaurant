import 'package:flutter/material.dart';

class ReservationDetailPage extends StatefulWidget {
  const ReservationDetailPage({super.key});

  @override
  State<ReservationDetailPage> createState() => _ReservationDetailPageState();
}

class _ReservationDetailPageState extends State<ReservationDetailPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = arguments['res name'];
    final date = arguments['res_date'];
    final time = arguments['res_time'];
    final code = arguments['res_code'];
    bool notify = arguments['notify'];

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
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      date.split(',')[0] + ', ' + date.split(',')[1],
                      style: const TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
                Text(
                  time,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Restaurant Name",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Confirmation Code",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  code,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cancellation Policy",
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  "Free cancellation before check-in of 24 hrs. No refund after less than 24 hrs.",
                  maxLines: 2,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
            if (notify) // Display button only if `notify` is true
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        const snackBar = SnackBar(
                          content: Text('You will be notified through SMS or Email'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        overlayColor: Colors.grey[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fixedSize: const Size(150, 40),
                      ),
                      child: const Text(
                        "Notify me",
                        style: TextStyle(color: Colors.black),
                      ),
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
