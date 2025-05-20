import 'package:firebase_database/firebase_database.dart'; // Import Firebase Realtime Database
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant/Home_page.dart'; // Import for TextInputFormatter

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers for each field
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  String? userId; // Make userId nullable


  @override
  void initState() {
    super.initState();
    // Initialize the controllers with empty values
    nameController = TextEditingController();
    addressController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      // Initialize userId and other fields
      userId = arguments["uid"]; // userId can be null
      if (userId == null || userId!.isEmpty) {
        // Handle the error when userId is not provided
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User ID is missing")));
        Navigator.pop(context);
      } else {
        // Populate the text fields with existing data
        nameController.text = arguments["name"] ?? "";
        addressController.text = arguments["address"] ?? "";
        phoneController.text = arguments["phone"] ?? "";
        emailController.text = arguments["email"] ?? "";
      }
    } else {
      // Handle the case where arguments are null
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No data found")));
      Navigator.pop(context);
    }
  }


  @override
  void dispose() {
    // Dispose controllers
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // Function to update profile in Firebase Realtime Database
  Future<void> _updateProfile() async {
    try {
      if (userId == null || userId!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User ID is missing")));
        return;
      }

      // Reference to the user's profile in the Realtime Database
      DatabaseReference profileRef = FirebaseDatabase.instance.ref('Users/$userId'); // Use the userId

      // Update the profile data
      await profileRef.update({
        'Address': addressController.text,
        'Phone': phoneController.text,
      });

      const snackBar = SnackBar(
        content: Text("Profile Updated Successfully"),
        elevation: 5,
        duration: Duration(seconds: 1),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(initialTabIndex: 2), // Set the desired tab index
        ),
      );

    } catch (e) {
      print("Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error updating profile")));
    }
  }

  Future<String?> fetchImageUrl(String uid) async {
    try {
      DatabaseReference userRef = FirebaseDatabase.instance
          .ref()
          .child("Users")
          .child(uid)
          .child("Profile value");

      DataSnapshot snapshot = await userRef.get();

      if (snapshot.exists) {
        String imageUrl = snapshot.value.toString();
        print(imageUrl);
        if(imageUrl!="No") {
          return imageUrl; // Return the URL if found.
        }
        else{
          return null;
        }
      } else {
        print("No image URL found in the database.");
        return null; // Return null if no URL is present.
      }
    } catch (e) {
      print("Error fetching image URL: $e");
      return null; // Return null in case of an error.
    }
  }


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
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: _updateProfile, // Call update profile method
              icon: const Icon(Icons.check),
            ),
          ),
        ],
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                maxRadius: 90,
                minRadius: 90,
                child: FutureBuilder<String?>(
                  future: fetchImageUrl(userId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return ClipOval(
                        child: Image.network(
                          snapshot.data!,  // The image URL
                          width: 180,
                          height: 180,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            // If the image is still loading, show a loading spinner
                            if (loadingProgress == null) {
                              return child; // If the image is loaded, display the image
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null, // Show progress if available
                                ),
                              );
                            }
                          },
                        ),
                      );
                    } else {
                      return Image.asset(
                        "assets/user.png",
                        width: 180,
                        height: 180,
                        fit: BoxFit.contain,
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              _buildTextField("Name", nameController, readOnly: true),
              _buildTextField("Address", addressController, maxLines: 5),
              _buildTextField("Phone", phoneController, keyboardType: TextInputType.phone, inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
              _buildTextField("Email", emailController, readOnly: true),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build reusable TextField with a label
  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1, bool readOnly = false, TextInputType keyboardType = TextInputType.text, List<TextInputFormatter> inputFormatters = const []}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(label),
          ),
          Container(
            width: double.infinity, // Full width
            height: maxLines == 1 ? 60 : 120, // Adjust height based on maxLines
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              readOnly: readOnly, // Make the field read-only
              keyboardType: keyboardType, // Set the keyboard type for phone numbers
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
