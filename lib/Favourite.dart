import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  late DatabaseReference _database;
  final List<String> _favoriteRestaurants = [];
  final List<String> _filteredRestaurants = [];
  String _searchQuery = "";
  late String _currentUserUID;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _currentUserUID = user.uid;
      _database = FirebaseDatabase.instance.ref().child("Users").child(_currentUserUID).child('Favourites');

      // Fetch favorites from Firebase
      await _fetchFavoriteRestaurants();
    }
  }

  /// Fetch favorite restaurants from Firebase
  Future<void> _fetchFavoriteRestaurants() async {
    final snapshot = await _database.get();

    if (snapshot.exists) {
      final favorites = Map<String, dynamic>.from(snapshot.value as Map);
      setState(() {
        _favoriteRestaurants.clear();
        _favoriteRestaurants.addAll(favorites.keys);
        _filteredRestaurants.clear();
        _filteredRestaurants.addAll(_favoriteRestaurants);
      });
    }
  }

  /// Filter the restaurants based on search query
  void _filterRestaurants(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredRestaurants.clear();
        _filteredRestaurants.addAll(_favoriteRestaurants);
      } else {
        _filteredRestaurants.clear();
        _filteredRestaurants.addAll(
          _favoriteRestaurants.where((restaurant) =>
              restaurant.toLowerCase().contains(query.toLowerCase())),
        );
      }
    });
  }

  /// Remove a restaurant from the favorites list in Firebase
  Future<void> _removeRestaurantFromFavorites(String restaurantName) async {
    await _database.child(restaurantName).remove(); // Remove the restaurant from Firebase
    setState(() {
      _favoriteRestaurants.remove(restaurantName); // Remove from local list
      _filteredRestaurants.remove(restaurantName); // Remove from filtered list
    });
    print('$restaurantName removed from favorites!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                onChanged: _filterRestaurants,
                decoration: InputDecoration(
                  labelText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            // Favorite Restaurants List
            Expanded(
              child: _filteredRestaurants.isEmpty
                  ? const Center(
                child: Text(
                  "No favorite restaurants found.",
                  style: TextStyle(fontSize: 16),
                ),
              )
                  : ListView.builder(
                itemCount: _filteredRestaurants.length,
                itemBuilder: (context, index) {
                  final restaurantName = _filteredRestaurants[index];
                  return Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        title: Text(
                          restaurantName,
                          style: const TextStyle(fontSize: 18),
                        ),
                        leading: Container(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            // Half of the height for a circular shape
                            child: Image.asset(
                              "assets/res_img.png",
                              fit: BoxFit.cover, // Ensures the image fits the circular container
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () => _removeRestaurantFromFavorites(restaurantName),
                          icon: const Icon(Icons.close),
                          color: Colors.red,
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, "/Restaurant",arguments: restaurantName);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}