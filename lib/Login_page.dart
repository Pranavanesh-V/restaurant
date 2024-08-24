import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String emailId = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 50,right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 130,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Login",style: TextStyle(
                  fontSize: 40
                      ,color: Colors.red
                ),),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            const Text("Email ID",
              style: TextStyle(
                  fontSize: 22
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Email Address",
                  hintStyle: TextStyle(
                    color: Colors.grey
                  ),
                  prefixIcon:Icon(Icons.person),
                  label: Text("Email Id"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(100)
                      )
                  ),
                ),
                autofocus: true,
                enableIMEPersonalizedLearning: true,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (text){
                  emailId = text;
                },
                onChanged: (text){
                  emailId = text;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Password",
              style: TextStyle(
                fontSize: 22
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                  prefixIcon:Icon(Icons.person),
                  label: Text("Password"),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(100)
                      )
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                maxLines: 1,
                enableSuggestions: true,
                enableIMEPersonalizedLearning: true,
                onSubmitted: (text){
                  password = text;
                },
                onChanged: (text){
                  password = text;
                },
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 10,),
                TextButton(
                  onPressed: (){},
                  child: const Text("forgot password?",style: TextStyle(
                    fontSize:18,
                    color: Colors.black,
                  ),),
                ),
              ],
            ),
            const SizedBox(height: 100,),
            Center(
              child: FilledButton.icon(
                  onPressed: (){
                    Navigator.pushNamed(context, "/Home");
                    },
                  label: const Icon(Icons.arrow_right_alt_sharp),
                style: FilledButton.styleFrom(
                  elevation: 5.0,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}