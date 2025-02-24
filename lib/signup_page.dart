import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hashcovet_machine_test/constants.dart';
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
        body: ListView(
          padding: EdgeInsets.all(size.width * 0.05),
          children: [
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
                            content: Text("Error occured: ${error.toString()}"),
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
                    style: const TextStyle(
                        color: Color.fromARGB(255, 163, 163, 163),
                        fontSize: 14),
                    children: [
                      const TextSpan(text: 'Already have an account ?'),
                      TextSpan(
                          text: ' Login ',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 127, 191, 255),
                              fontSize: 15),
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
    );
  }
}
