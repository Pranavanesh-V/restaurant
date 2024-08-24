import 'package:flutter/material.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, "/Edit");
          },child: const Text("Edit",style: TextStyle(
            color: Colors.black
          ),),),
          ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 90,
              minRadius: 90,
              child: Image.asset(
                "assets/user.png",width: 180,height: 180,fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Name"),
                    ),
                    Container(
                      width: 500, // Set the width
                      height: 60, // Set the height
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Set the border color
                          width: 2.0, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(10.0), // Optional: Set border radius
                      ),
                      child: const Center(
                        child: Text(
                          "Example Name",
                          style: TextStyle(
                            fontSize: 16.0, // Optional: Set text size
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Address"),
                    ),
                    Container(
                      width: 500, // Set the width
                      height: 120, // Set the height
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Set the border color
                          width: 2.0, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(10.0), // Optional: Set border radius
                      ),
                      child: const Center(
                        child: Text(
                          "Example Address",
                          style: TextStyle(
                            fontSize: 16.0, // Optional: Set text size
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Phone"),
                  ),
                  Container(
                    width: 500, // Set the width
                    height: 60, // Set the height
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Set the border color
                        width: 2.0, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(10.0), // Optional: Set border radius
                    ),
                    child: const Center(
                      child: Text(
                        "Example Phone number",
                        style: TextStyle(
                          fontSize: 16.0, // Optional: Set text size
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Email"),
                    ),
                    Container(
                      width: 500, // Set the width
                      height: 60, // Set the height
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Set the border color
                          width: 2.0, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(10.0), // Optional: Set border radius
                      ),
                      child: const Center(
                        child: Text(
                          "Example Email",
                          style: TextStyle(
                            fontSize: 16.0, // Optional: Set text size
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
