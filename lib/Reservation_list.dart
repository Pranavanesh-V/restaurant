import 'package:flutter/material.dart';

class ReservationList extends StatefulWidget {
  const ReservationList({super.key, required this.uid});

  final String uid;

  @override
  State<ReservationList> createState() => _ReservationListState();
}

class _ReservationListState extends State<ReservationList> {

  String uid="";

  @override
  void initState() {
    super.initState();
    uid=widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context,int x)
        {
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/Reservation_detail");
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Card(
                elevation: 5,
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/past_dates.png",width: 80,height: 80,),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Center(child: Text("Hidden Gem",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),
                              Text("August 14,8:52 pm"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 50,),
                        const Text("4 Guest"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
