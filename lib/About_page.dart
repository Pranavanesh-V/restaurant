import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                "About Our Restaurant Reservation App",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                "Welcome to DINE EASY, your smart dining companion that connects food lovers with their favorite restaurants effortlessly. Our platform simplifies the table reservation process so you can focus on what truly matters — enjoying great food and making unforgettable memories.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Our Mission",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                "At DINE EASY, our mission is to enhance your dining experience by making restaurant reservations fast, easy, and reliable. Whether it's a casual meal, a family gathering, or a romantic dinner, we make sure your table is ready when you are.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Our Story",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                "DINE EASY was launched in 2023 by a group of foodies and tech enthusiasts who were frustrated with long waits and last-minute chaos at restaurants. We envisioned a platform where users could find and reserve tables in seconds. Today, we’re proud to serve thousands of diners and restaurants across the city.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Why Choose DINE EASY?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                " \n ⁕ Instant Booking: Reserve your table at top restaurants in just a few taps.\n\n ⁕ Real-time Availability: View live table availability and book instantly.\n\n ⁕ Personalized Suggestions: Get restaurant recommendations based on your preferences and location.\n\n ⁕ Rewards & Offers: Earn loyalty points and access exclusive dining deals.\n\n ⁕ Seamless Experience: Avoid long waits and dine at your convenience with our intuitive and user-friendly app.",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Join Us for the Perfect Dining Experience",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                "Whether you're planning a lunch meeting, family dinner, or a night out with friends, DINE EASY is here to make it hassle-free. We’re committed to connecting you with great food and great places, anytime, anywhere.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                "Contact Us",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 5),
              Text(
                "Have questions or feedback? We'd love to hear from you! Reach out to us at dineeasyhelp@gmail.com or call 9876543210. Let’s make dining out smarter and simpler together.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
