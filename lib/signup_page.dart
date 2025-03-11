import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hashcovet_machine_test/constants/constants.dart';
import 'package:hashcovet_machine_test/constants/customColors.dart';
import 'package:hashcovet_machine_test/constants/customColors.dart';
import 'package:hashcovet_machine_test/login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController repasswordController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: ListView(
            padding: EdgeInsets.all(size.width * 0.05),
            shrinkWrap: true,
            children: [
              Text(
                "SIGN UP",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: customTextColor,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              TextField(
                  controller: emailController,
                  decoration: inputDecoration("Email", Icons.mail)),
              SizedBox(height: size.height * 0.02),
              TextField(
                  controller: passwordController,
                  decoration:
                      inputDecoration('Password', Icons.lock_outline_rounded)),
              SizedBox(height: size.height * 0.02),
              TextField(
                  controller: repasswordController,
                  decoration: inputDecoration(
                      're-enter Password', Icons.lock_outline_rounded)),
              SizedBox(height: size.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  if (passwordController.text == repasswordController.text) {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((onValue) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Account Created!"),
                        duration: Duration(seconds: 5),
                      ));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ));
                    }).onError((error, stackTrace) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content:
                                  Text("Error occured: ${error.toString()}"),
                            );
                          });
                    });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text('Passwords must be same'),
                          );
                        });
                  }
                },
                style: buttonStyle,
                child: const Text("Sign up"),
              ),
              SizedBox(height: size.height * 0.02),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(color: customTextColor, fontSize: 14),
                      children: [
                        const TextSpan(text: 'Already have an account ?'),
                        TextSpan(
                            text: ' Login ',
                            style: TextStyle(
                                color: customLinkTextColor, fontSize: 15),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                const CircularProgressIndicator();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ));
                                log('login', name: 'login');
                              }),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}
