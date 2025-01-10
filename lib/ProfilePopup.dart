import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePopup extends StatefulWidget {
  const ProfilePopup({super.key,required this.username,required this.uid,required this.currentImageUrl, required this.onImageUpdated});

  final String uid;
  final String username;
  final String? currentImageUrl;
  final Function(String) onImageUpdated; // Callback to notify parent of updated image URL.

  @override
  State<ProfilePopup> createState() => _ProfilePopupState();
}

class _ProfilePopupState extends State<ProfilePopup> {
  File? _selectedImageFile;
  bool _isLoading = false;
  String? _downloadUrl;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _downloadUrl =
        widget.currentImageUrl; // Load the current image URL initially.
  }

  // Pick an image from the gallery.
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
      });
    }
  }

  // Upload the selected image to Firebase Storage.
  Future<void> _uploadImage() async {
    if (_selectedImageFile == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Generate a unique file name.
      String fileName = widget.username;

      // Reference to Firebase Storage.
      Reference storageRef = FirebaseStorage.instance.ref().child(
          "Users/$fileName");

      // Upload file.
      UploadTask uploadTask = storageRef.putFile(_selectedImageFile!);
      TaskSnapshot snapshot = await uploadTask;

      // Get the download URL.
      String downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _downloadUrl = downloadUrl;
      });

      widget.onImageUpdated(downloadUrl); // Notify parent of updated URL.

      uploadData(widget.uid, widget.username, downloadUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading image: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> uploadData(String uid, String username, String imageUrl) async {
    // Reference to the "Users" node in the database, specifically the user by UID
    DatabaseReference userRef = FirebaseDatabase.instance.ref()
        .child("Users")
        .child(uid);

    try {
      // Update only the Profile and Profile value fields, leaving other data intact
      await userRef.update({
        'Profile value': imageUrl, // Update the profile image URL field
        'Profile': "Yes", // Update the profile field
      });

      print("Data uploaded successfully!");
    } catch (e) {
      print("Error uploading data: $e");
    }
  }

  // Delete the current image from Firebase Storage.
  Future<void> _deleteImage() async {
    /*if (_downloadUrl == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Reference to the image in Firebase Storage.
      Reference storageRef = FirebaseStorage.instance.refFromURL(_downloadUrl!);

      // Delete the image.
      await storageRef.delete();

      setState(() {
        _downloadUrl = null; // Reset to default image.
        _selectedImageFile = null; // Remove the selected file.
      });

      widget.onImageUpdated(''); // Notify parent to reset the profile.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting image: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Profile Picture'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Display the current, selected, or default image in a circular shape.
          ClipOval(
            child: _selectedImageFile != null
                ? Image.file(
              _selectedImageFile!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            )
                : _downloadUrl != null && _downloadUrl!.isNotEmpty
                ? Image.network(
              _downloadUrl!,
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            )
                : Image.asset(
              'assets/user.png',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          // Buttons for selecting and uploading images.
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Select Image'),
              ),
              ElevatedButton(
                onPressed: _isLoading ? null : _uploadImage,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Upload/Save'),
              ),
              ElevatedButton(
                onPressed: _isLoading ? null : _deleteImage,
                child: const Text('Delete'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }
}