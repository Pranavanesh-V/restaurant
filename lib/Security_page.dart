import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({super.key});

  @override
  State<SecurityPage> createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Security"),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.red,
        titleSpacing: 50,
        titleTextStyle: const TextStyle(
            fontSize: 25,
            color: Colors.black
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: [
              Image.asset("assets/security.png",width: 200,height: 200,),
              const SizedBox(height: 20,),
              const Text("Security and Privacy",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("At Blood Donation , we take the security and privacy of your information very seriously. We are committed to ensuring that your data is protected and that your experience with our app is safe and secure. This page outlines the measures we have in place to safeguard your information.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Data Encryption",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("All data transmitted between your device and our servers is encrypted using industry-standard SSL/TLS encryption protocols. This means that your personal information, including login credentials and communication with our servers, is fully protected from eavesdropping.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("User Authentication",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("To access your personal profile and donation history, we employ robust user authentication mechanisms. This includes secure login processes, password encryption, and optional two-factor authentication (2FA) to ensure that only authorized individuals can access your account",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Data Access Control",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("Our team follows strict access control procedures. Only authorized personnel with a legitimate need are granted access to user data, and even then, it's on a need-to-know basis. We regularly audit and review access logs to prevent unauthorized access.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Privacy Setting",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("You have control over your data. Our app provides you with privacy settings that allow you to choose what information you want to share and with whom. You can update these settings at any time through your profile.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Data Retention and Deletion",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("We retain your data only for as long as necessary to provide our services or as required by law. You can request the deletion of your account and data at any time, and we will promptly comply with your request.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Third-Party Services",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("While we work with third-party services for various app functionalities, we carefully select our partners and ensure they maintain high standards of security and privacy. We encourage you to review the privacy policies of these third-party services when using them through our app.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Security Updates",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("We regularly update our app to address security vulnerabilities and ensure the latest security patches are applied. We appreciate your cooperation in keeping the app updated to the latest version to benefit from these security enhancements.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Report Security Concerns",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("If you ever come across a security concern or believe your account has been compromised, please contact our security team immediately at [Security Email/Phone]. We take all reports seriously and will investigate promptly.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Your Trust Matters",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 5,),
              const Text("Your trust in Blood Donation is our most valuable asset. We are dedicated to maintaining the highest standards of security and privacy in every aspect of our app. If you have any questions or concerns regarding the security of your data, please don't hesitate to contact us.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Thank you for being a part of our community and for entrusting us with your information.",textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}