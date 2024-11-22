import 'package:flutter/material.dart';

class List_restaurant extends StatefulWidget {

  final List<String> displayRes;

  List_restaurant(this.displayRes, {super.key});

  @override
  State<List_restaurant> createState() => _List_restaurantState();
}

class _List_restaurantState extends State<List_restaurant> {

  late List<bool> _favoriteStates;

  @override
  void initState() {
    super.initState();
    // Initialize favorite states for all items as false
    _favoriteStates = List<bool>.filled(widget.displayRes.length, false);
  }

  void _toggleFavorite(int index) {
    setState(() {
      _favoriteStates[index] = !_favoriteStates[index];
    });
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
                          color:
                          _favoriteStates[index] ? Colors.red : Colors.grey,
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
}