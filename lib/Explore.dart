import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/Restaurant_list.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Map<String, dynamic>> restaurantList = []; // List to store full restaurant details
  List<Map<String, dynamic>> displayRes = []; // List to store filtered restaurant details
  String? message;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchRestaurantData(); // Fetch data when the screen is initialized
  }

  Future<void> fetchRestaurantData() async {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child("Restaurants");

    DataSnapshot snapshot = await databaseRef.get();

    if (snapshot.exists) {
      // Parse Firebase data into a list of maps (name, type, rating, etc.)
      Map<String, dynamic> restaurants = Map<String, dynamic>.from(snapshot.value as Map);
      setState(() {
        restaurantList = restaurants.values.map((e) => Map<String, dynamic>.from(e)).toList();
        displayRes = List.from(restaurantList); // Initialize displayRes with all restaurants
        isLoading = false; // Set loading to false after data is fetched
      });
    } else {
      setState(() {
        isLoading = false; // Stop loading if no data exists
      });
    }
  }

  void check(String restaurantName) {
    setState(() {
      displayRes.clear();
      for (var restaurant in restaurantList) {
        if (restaurant['Name'].toLowerCase().contains(restaurantName.toLowerCase())) {
          displayRes.add(restaurant);
        }
      }
      if (displayRes.isEmpty) {
        message = "Restaurant not found";
      } else {
        message = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: TextField(
              onSubmitted: (x) {
                check(x);
              },
              onChanged: (x) {
                check(x);
              },
              decoration: const InputDecoration(
                hintText: "Search your favourite restaurant",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                prefixIcon: Icon(Icons.search),
                label: Text("Search"),
              ),
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Positioned(
                  top: 550,
                  right: 500,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 200.0),
                    child: Center(
                      child: CircularProgressIndicator(), // Loading indicator while data is being fetched
                    ),
                  ),
                ) : displayRes.isNotEmpty
                ? Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  width: 350,
                  height: 518,
                  child: List_restaurant(displayRes),
                )
                : Center(
                    child: Text(
                      message ?? '',
                      style: const TextStyle(fontSize: 18),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
