import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class List_restaurant extends StatefulWidget {

  final List<String> displayRes;

  List_restaurant(this.displayRes, {super.key});

  @override
  State<List_restaurant> createState() => _List_restaurantState();
}

class _List_restaurantState extends State<List_restaurant> {

  late DatabaseReference _database;
  late List<bool> _favoriteStates;
  final List<String> _favoriteRestaurants = [];
  late String _currentUserUID;

  @override
  void initState() {
    super.initState();
    _favoriteStates = List<bool>.filled(widget.displayRes.length, false);
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      _currentUserUID = user.uid;
      _database = FirebaseDatabase.instance.ref().child("Users").child(_currentUserUID).child('Favourites');

      // Fetch initial favorite states
      _loadFavorites();
    }
  }

  /// Fetch favorite restaurants and sync with the local list
  Future<void> _loadFavorites() async {
    final snapshot = await _database.get();

    if (snapshot.exists) {
      final favorites = Map<String, dynamic>.from(snapshot.value as Map);
      setState(() {
        _favoriteRestaurants.clear();
        _favoriteRestaurants.addAll(favorites.keys);
      });
      _syncFavoriteStates();
    }
  }

  /// Sync favorite states with `_favoriteRestaurants`
  void _syncFavoriteStates() {
    for (int i = 0; i < widget.displayRes.length; i++) {
      if (_favoriteRestaurants.contains(widget.displayRes[i])) {
        _favoriteStates[i] = true;
      }
    }
  }

  /// Toggle favorite state and update Firebase Realtime Database
  void _toggleFavorite(int index) async {
    final restaurantName = widget.displayRes[index];

    setState(() {
      _favoriteStates[index] = !_favoriteStates[index];
    });

    if (_favoriteStates[index]) {
      // Add to Firebase
      await _database.child(restaurantName).set({'value': 'yes'});
      print('$restaurantName added to favorites!');
    } else {
      // Remove from Firebase
      await _database.child(restaurantName).remove();
      print('$restaurantName removed from favorites!');
    }

    // Reload favorites
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.displayRes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print(widget.displayRes[index]);
            Navigator.pushNamed(context, "/Restaurant");
          },
          child: Card(
            elevation: 5,
            child: Container(
              width: 350,
              height: 255,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/res_img.png",
                    width: 370,
                    height: 180,
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.displayRes[index],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Cafe",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            "4.5",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          _toggleFavorite(index);
                        },
                        icon: Icon(
                          _favoriteStates[index]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: _favoriteStates[index]
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up Firebase listeners if added
    super.dispose();
  }
}