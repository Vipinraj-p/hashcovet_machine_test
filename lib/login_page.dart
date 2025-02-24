import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hashcovet_machine_test/constants.dart';
import 'package:hashcovet_machine_test/dashboard.dart';
import 'package:hashcovet_machine_test/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: ListView(padding: EdgeInsets.all(size.width * 0.05), children: [
          TextField(
            controller: emailController,
            decoration: inputDecoration('Email', Icons.mail),
          ),
          SizedBox(height: size.height * 0.02),
          TextField(
              controller: passwordController,
              decoration:
                  inputDecoration('Password', Icons.lock_outline_rounded)),
          SizedBox(height: size.height * 0.02),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Dashboard()));
                }).onError((error, stackTrace) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            content:
                                Text('Wrong input\nError:${error.toString()}'));
                      });
                });
              },
              style: buttonStyle,
              child: Text("login")),
          SizedBox(height: size.height * 0.02),
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: const TextStyle(
                      color: const Color.fromARGB(255, 163, 163, 163),
                      fontSize: 14),
                  children: [
                    const TextSpan(text: 'Don\'t you have an account ?'),
                    TextSpan(
                        text: '  Sign up ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 127, 191, 255),
                            fontSize: 15),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            const CircularProgressIndicator();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ));
                            log('login', name: 'login');
                          }),
                  ]))
        ]),
      ),
    );
  }
}
