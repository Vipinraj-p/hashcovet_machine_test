import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hashcovet_machine_test/constants/constants.dart';
import 'package:hashcovet_machine_test/login_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final email = currentUser?.email;
    final displayName = currentUser?.displayName;
    final photoURL = currentUser?.photoURL;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white38,
        title: const Text("DashBoard"),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.02),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  photoURL ?? "https://demofree.sirv.com/nope-not-here.jpg"),
            ),
            Text(
              email ?? "Email Not Found",
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            RichText(
                text: TextSpan(children: [
              const TextSpan(text: "Name :"),
              TextSpan(text: displayName ?? "No Name Found"),
            ])),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await GoogleSignIn().signOut();
                    FirebaseAuth.instance.signOut().then((onValue) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    }).onError((error, stackTrace) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                content: Text(
                                    'Something went wrong\nError:${error.toString()}'));
                          });
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Something went wrong !")));
                    log(e.toString());
                  }
                },
                style: buttonStyle,
                child: const Text("SignOut"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
