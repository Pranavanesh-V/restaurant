import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class List_restaurant extends StatefulWidget {
  final List<Map<String, dynamic>> displayRes; // List of restaurant details

  const List_restaurant(this.displayRes, {super.key});

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

  void _syncFavoriteStates() {
    for (int i = 0; i < widget.displayRes.length; i++) {
      if (_favoriteRestaurants.contains(widget.displayRes[i]['Name'])) {
        _favoriteStates[i] = true;
      }
    }
  }

  void _toggleFavorite(int index) async {
    final restaurantName = widget.displayRes[index]['Name'];

    setState(() {
      _favoriteStates[index] = !_favoriteStates[index];
    });

    if (_favoriteStates[index]) {
      await _database.child(restaurantName).set({'value': 'yes'});
    } else {
      await _database.child(restaurantName).remove();
    }

    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.displayRes.length,
      itemBuilder: (BuildContext context, int index) {
        var restaurant = widget.displayRes[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/Restaurant",arguments: restaurant['Name']);
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
                    restaurant['imageUrl'] ?? "assets/res_img.png",
                    width: 370,
                    height: 180,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      restaurant['Name'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurant['Type'] ?? 'N/A',
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              restaurant['Ratings'].toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
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
    super.dispose();
  }
}
