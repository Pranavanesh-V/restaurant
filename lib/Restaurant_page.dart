import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Special_menu.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  List<List<String>> d = []; // List to hold special menu items
  List<List<String>> d1 = []; // List to hold restaurant details
  String restaurantName = ""; // Variable to store the passed restaurant name
  bool isLoading = true; // To track loading state
  bool hasSpecialMenu = false; // To check if special menu exists

  DatabaseReference getDatabaseRef(String restaurantName) {
    return FirebaseDatabase.instance.ref("Restaurants/$restaurantName/Special Menu");
  }

  DatabaseReference getDatabaseRef1(String restaurantName) {
    return FirebaseDatabase.instance.ref("Restaurants/$restaurantName");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve restaurant name from ModalRoute
    final String? passedRestaurantName = ModalRoute.of(context)?.settings.arguments as String?;

    if (passedRestaurantName != null) {
      setState(() {
        restaurantName = passedRestaurantName;
      });

      // Fetch restaurant details and special menu for the specific restaurant
      _fetchRestaurantDetails(passedRestaurantName);
      _fetchSpecialMenu(passedRestaurantName);
    }
  }

  Future<void> _fetchRestaurantDetails(String restaurantName) async {
    final databaseRef = getDatabaseRef1(restaurantName);

    try {
      final snapshot = await databaseRef.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        if (data.isNotEmpty) {
          setState(() {
            d1 = [
              [
                restaurantName,
                data['Location'].toString(),
                data['Type'].toString(),
                data['Ratings'].toString(),
                data['Phone'].toString(),
                data['Mail'].toString(),
                data['Timing'].toString()
              ]
            ];
          });
        }
      } else {
        setState(() {
          d1 = []; // No restaurant details found
        });
      }
    } catch (e) {
      debugPrint('Error fetching restaurant details: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchSpecialMenu(String restaurantName) async {
    final databaseRef = getDatabaseRef(restaurantName);

    try {
      final snapshot = await databaseRef.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        if (data.isNotEmpty) {
          setState(() {
            hasSpecialMenu = true;
            d = data.entries
                .map((entry) => [
              entry.key.toString(),
              entry.value['Description'].toString(),
              "\$${entry.value['Price']}",
            ])
                .toList();
          });
        }
      } else {
        setState(() {
          hasSpecialMenu = false; // No special menu exists
        });
      }
    } catch (e) {
      debugPrint('Error fetching special menu: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Food"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(fontSize: 25, color: Colors.black),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset("assets/restaurant.png", width: 120),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Display restaurant name from d1 list
              Text(
                d1.isNotEmpty ? d1[0][0] : 'Loading...',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Display restaurant location and type
              Text(
                d1.isNotEmpty ? '${d1[0][2]}' : 'Loading type...',
              ),
              Text(
                d1.isNotEmpty ? '${d1[0][3]}' : 'Loading ratings...',
              ),
              Text(
                d1.isNotEmpty ? 'Timings : ${d1[0][6].substring(1,30)}' : 'Loading time...',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Booking");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  overlayColor: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(500, 50),
                  maximumSize: const Size(500, 50),
                  minimumSize: const Size(250, 25),
                ),
                child: const Text(
                  "Book",
                  style: TextStyle(color: Colors.black),
                ),
              ),const SizedBox(height: 10),
              const Text(
                "Photos",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Image.asset("assets/res_img (1).png", width: 150, height: 150),
                  const SizedBox(width: 20),
                  Image.asset("assets/res_img (2).png", width: 150, height: 150),
                ],
              ),const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset("assets/res_img (3).png", width: 150, height: 150),
                  const SizedBox(width: 20),
                  Image.asset("assets/res_img (4).png", width: 150, height: 150),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Image.asset("assets/res_img (5).png", width: 150, height: 150),
                  const SizedBox(width: 20),
                  Image.asset("assets/res_img (6).png", width: 150, height: 150),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Special Menu",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              isLoading
                  ? const Center(child: CircularProgressIndicator()) // Show loader
                  : hasSpecialMenu
                  ? SizedBox(
                height: d.length * 150.0, // Dynamic height: 80.0 per item
                child: SpecialMenu(d), // Pass the menu data to SpecialMenu
              )
                  : const Text(
                "No special menu available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ), // Show no special menu message
              const SizedBox(height: 10),
              const Text(
                "Contact Us",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text(
                    "Phone no:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(d1.isNotEmpty ? '${d1[0][4]}' : 'Loading phone...',),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    "Email Id:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(d1.isNotEmpty ? '${d1[0][5]}' : 'Loading mail...',),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  const Text(
                    "Location:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(d1.isNotEmpty ? '${d1[0][1]}' : 'Loading location...',),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/Reservation");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  overlayColor: Colors.grey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fixedSize: const Size(500, 50),
                  maximumSize: const Size(500, 50),
                  minimumSize: const Size(250, 25),
                ),
                child: const Text(
                  "View Reservations",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
