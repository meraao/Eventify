import 'package:eventify01/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({super.key});
  State<Login> createState() => _LoginState();
}

const Color kScaffoldBackground = Color(0xFF2C2C2C);
const Color kDarkGreen = Color(0xFF3A6B4C);
const Color kMediumGreen = Color(0xFF6A9B7A);
const Color kLightGreen = Color(0xFF9DC8A8);
const Color kTextGreen = Color(0xFFA8D5B4);
const Color kButtonGreen = Color(0xFF4A7C59);
const Color kTextColor = Colors.white;

class _LoginState extends State<Login> {
  TextEditingController emController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Future SignUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emController.text.trim(),
      password: passController.text.trim(),
    );
  }

  Future SignIn() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emController.text.trim(),
            password: passController.text.trim(),
          );
      if (userCredential.user != null) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Homescreen()),
          (route) => false,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  String errorMsgUser = "";
  String errorMsgPass = "";
  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emController.text.trim(),
        password: passController.text.trim(),
      );
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
    
      // appBar: //ThemeData(primarySwatch: Color(), useMaterial3: false);
      // AppBar(
      //   title: Text("Welcome to Eventify!"),
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // 2. HORIZONTAL: This centers everything (Text, Buttons) horizontally
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 200),

              SizedBox(
                child: Text(
                  "Welcome to Eventify!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),

              SizedBox(height: 40),
              Text(
                "Log In",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 16),
              Container(
                width: 350,
                child: TextField(
                  controller: emController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    label: Text('Username'),
                    border: OutlineInputBorder(),
                    helperText: errorMsgUser,
                  ),
                ),
              ),
              Container(
                width: 350,
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    helperText: errorMsgPass,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    if (passController.text.isEmpty) {
                      errorMsgPass = "Please Fill The Password.";
                    } else if (emController.text.isEmpty) {
                      errorMsgUser = "Please enter a valid Username";
                    }
                    SignIn();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    overlayColor: kDarkGreen,
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Text(
                "Don't have an account?",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    signUp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kButtonGreen,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    overlayColor: kDarkGreen,
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // //crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
