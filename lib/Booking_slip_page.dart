import 'package:flutter/material.dart';

class BookingSlipPage extends StatefulWidget {
  const BookingSlipPage({super.key});

  @override
  State<BookingSlipPage> createState() => _BookingSlipPageState();
}

class _BookingSlipPageState extends State<BookingSlipPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.pushNamed(context, "/Home");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Food"),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed:()async{
                    Navigator.pushNamed(context, "/Home");
                  },
                   icon:  Icon(Icons.close,size: 30,),
                ),
              ),
            ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red,
          titleSpacing: 50,
          titleTextStyle: const TextStyle(
              fontSize: 25,
              color: Colors.black
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Image.asset("assets/res_img (3).png",width: 360,height: 220,alignment: Alignment.center,fit: BoxFit.cover),
            const Padding(
              padding: EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your Reservation is confirmed",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "We've sent you an email with all the details. You can also add this to your calendar",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Date & Time",
                    style: TextStyle(
                        fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "August 29,8:06 pm",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Restaurant Name",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Hidden Gem",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Location",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Chennai",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Confirmation Code",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "SHSNZ2R",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
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
