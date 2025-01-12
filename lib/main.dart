import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Signup_page.dart';
import 'Landing_page.dart';
import 'Loading_page.dart';
import 'Login_page.dart';
import 'Home_page.dart';
import 'Restaurant_page.dart';
import 'Booking_page.dart';
import 'Reservation_page.dart';
import 'Booking_slip_page.dart';
import 'Reservation_detail_page.dart';
import 'Upcoming_bookings.dart';
import 'Past_bookings.dart';
import 'Personal_info_page.dart';
import 'Password_page.dart';
import 'Edit_profile_page.dart';
import 'Security_page.dart';
import 'About_page.dart';
import 'Password_reset_link_page.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBaXB9fqVYPxzjfyh068ky6Pv9JOU55Sbk",
            authDomain: "food-ee7a6.firebaseapp.com",
            databaseURL: "https://food-ee7a6-default-rtdb.firebaseio.com",
            projectId: "food-ee7a6",
            storageBucket: "food-ee7a6.appspot.com",
            messagingSenderId: "351451918792",
            appId: "1:351451918792:web:7363eadb4482677bfd90fd",
            measurementId: "G-C7CK8Z3BFM"
        )
    );
  }
  else {
    Firebase.initializeApp();
  }

  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => const LoadingPage(),
      "/Landing": (context) => const LandingPage(),
      "/Login": (context) => const LoginPage(),
      "/Sign": (context) => const SignUpPage(),
      "/Home": (context) => const HomePage( initialTabIndex: 0),
      "/Restaurant": (context) => const RestaurantPage(),
      "/Booking": (context) => const BookingPage(),
      "/Reservation": (context) => const ReservationPage(),
      "/Booking_slip": (context) => const BookingSlipPage(),
      "/Reservation_detail": (context) => const ReservationDetailPage(),
      "/Upcoming": (context) => const UpcomingBookings(),
      "/Past": (context) => const PastBookings(),
      "/Personal": (context) => const PersonalInfoPage(),
      "/Edit": (context) => const EditProfilePage(),
      "/Password": (context) => const PasswordPage(),
      "/Password_reset": (context) => const PasswordResetLinkPage(),
      "/Security": (context) => const SecurityPage(),
      "/About": (context) => const AboutPage(),
    },
  )
  );
}