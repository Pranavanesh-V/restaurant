import 'package:flutter/material.dart';
import 'package:restaurant/Restaurant_list.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {

  String? resName;
  List<String> restaurantList = ["hidden gem","Smith","kandravi"];
  List<String> displayRes = [];
  String? message;

  @override
  void initState() {
    super.initState();

    displayRes=List.from(restaurantList);

  }

  void check(String restaurantName)
  {
    setState(() {
      displayRes.clear();
      for(var n in restaurantList)
      {
        if (n.toLowerCase().contains(restaurantName.toLowerCase()))
        {
          displayRes.add(n);
        }
      }
      if(displayRes.isEmpty)
        {
          message="Restaurant Not found";
        }
      else{
        message="";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0,left: 20,right: 20),
            child: TextField(
              onSubmitted: (x){
                resName = x;
                check(resName!);
              },
              onChanged: (x){
                resName = x;
                check(resName!);
              },
              decoration: const InputDecoration(
                hintText: "Search your favourite restaurant",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(100)
                    )
                ),
                prefixIcon: Icon(Icons.search),
                label: Text("Search"),
              ),
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black
              ),
            ),
          ),displayRes.isNotEmpty?
          Container(
            padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
            width: 350,
            height: 518,
            child: List_restaurant(displayRes)
          ):Center(
            child: Text(message!,style: const TextStyle(
              fontSize: 18
            ),),
          ),
        ],
      ),
    );
  }
}
