import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.check)),
          ),
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
                      child: Center(
                        child: TextField(
                          onTapOutside: (x){
                            print(x);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none, // Remove the underline border
                            enabledBorder: InputBorder.none, // Ensure no border when enabled
                            focusedBorder: InputBorder.none,
                          ),
                          maxLines: 5,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
