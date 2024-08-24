import 'package:flutter/material.dart';
import 'Special_menu.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {

  List<List<String>> d=[
    ["Mixed Grill","\$25","Chicken,pork and lamb gyro with pita bread and tzatziki"],
    ["Grill Mixed Chicken","\$25","Chicken,pork and lamb gyro with pita bread and tzatziki"],
    ["Nothing big","\$25","Chicken,pork and lamb gyro with pita bread and tzatziki"]
  ];


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
      body:  Padding(
        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset("assets/restaurant.png",
                      width: 120,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Hidden Gem",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const Text("cafe"),
              const Text("4.5"),
              ElevatedButton(
                onPressed: (){
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
                  minimumSize: const Size(250, 25)
                ),
                child:const Text("Book",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height:10,
              ),
              const Text("Photos",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset("assets/res_img (1).png",width: 150,height: 150,),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/res_img (2).png",width: 150,height: 150,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Image.asset("assets/res_img (3).png",width: 150,height: 150,),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/res_img (4).png",width: 150,height: 150,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Image.asset("assets/res_img (5).png",width: 150,height: 150,),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/res_img (6).png",width: 150,height: 150,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Special Menu",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: SpecialMenu(d),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Contact Us",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text("Phone no:",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("8870330628"),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Text("Email Id:",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("pranavanesh.vimalraj@gmail.com"),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Text("Location:",style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Chennai"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: (){
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
                    minimumSize: const Size(250, 25)
                ),
                child:const Text("View Reservations",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )
        ),
      ),
    );
  }
}

