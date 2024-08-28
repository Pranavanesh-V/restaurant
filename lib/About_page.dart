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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Column(
            children: [
              SizedBox(height: 40,),
              Text("About Our Blood Donation App",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 5,),
              Text("About Our Blood Donation App Welcome to BLOOD DONATION, your trusted partner in saving lives through blood donation. We are passionate about connecting donors with those in need, and we're thrilled to share our story with you.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 20,),
              Text("Our Mission",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 5,),
              Text("At BLOOD DONATION, our mission is simple yet profound: to bridge the gap between blood donors and patients in need. We believe that every drop of blood donated has the power to make a life-saving difference. Our goal is to make the blood donation process easy, efficient, and accessible to everyone.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 20,),
              Text("Our Story",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 5,),
              Text("BLOOD DONATION was founded in 2023 by a group of dedicated individuals who were deeply moved by the scarcity of blood in medical facilities and the challenges faced by those seeking blood donations. Their vision was to create a platform that would make blood donation more convenient, reliable, and impactful. Over the years, our app has grown to become a leading force in the world of blood donation.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 20,),
              Text("Why Choose BLOOD DONATION?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 5,),
              Text(" \n ⁕ Effortless Donation: We've streamlined the donation process, so you can easily schedule appointments, find nearby donation centers, and keep track of your donation history. \n\n ⁕ Safety First: Your health and safety are our top priorities. We work closely with accredited blood banks and hospitals to ensure the highest standards of hygiene and safety. \n\n ⁕ Community of Heroes: Join a community of dedicated blood donors who are making a difference in the lives of countless patients. Every donation you make has the potential to save up to three lives. \n\n ⁕ Real-time Updates: Receive real-time alerts about urgent blood needs in your area, so you can respond quickly and help those in critical situations. \n\n ⁕ Educational Resources: Access valuable information about blood donation, its impact, and how you can maximize your contribution",textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 20,),
              Text("Join us in Making a Difference",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 5,),
              Text("Whether you're a regular blood donor or considering donating for the first time, BLOOD DONATION welcomes you with open arms. Together, we can ensure that no one ever has to suffer due to a shortage of blood. Thank you for being a part of our journey. Your support means the world to us, and it's the lifeline for many others.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 20,),
              Text("Contact Us",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 5,),
              Text("We'd love to hear from you! If you have any questions, feedback, or suggestions, please don't hesitate to reach out to our team at Contact abcd@gmail.com/123456789. Join us today, and let's save lives, one drop at a time.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              SizedBox(height: 20,),
              Text("Feel free to customize this \"About\" page to fit your specific blood donation app and its mission.",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              ),
              SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}
