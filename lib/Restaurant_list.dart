import 'package:flutter/material.dart';

class List_restaurant extends StatefulWidget {

  List<String> displayRes = [];

  List_restaurant(this.displayRes, {super.key});

  @override
  State<List_restaurant> createState() => _List_restaurantState();
}

class _List_restaurantState extends State<List_restaurant> {

  bool _isFavorite = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.displayRes.length,
        itemBuilder: (BuildContext context,int x)
        {
          return GestureDetector(
            onTap: (){
              print(widget.displayRes[x]);
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
                    Image.asset("assets/res_img.png",width: 370,height: 180,alignment: Alignment.center,fit: BoxFit.fill,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(widget.displayRes[x],
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
                              child: Text("Cafe",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text("4.5",style: TextStyle(
                              fontSize: 15,
                            ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: (){
                            _toggleFavorite();
                          },
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
