import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hashcovet_machine_test/constants.dart';
import 'package:hashcovet_machine_test/login_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final email = FirebaseAuth.instance.currentUser!.email!.isNotEmpty
        ? FirebaseAuth.instance.currentUser?.email
        : "User Not Found";
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white38,
        title: const Text("DashBoard"),
      ),
      body: Column(
        children: [
          const Icon(
            Icons.person_pin,
            size: 150,
            color: Colors.white38,
          ),
          Text(
            email!,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((onValue) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }).onError((error, stackTrace) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            content: Text(
                                'Something went wrong\nError:${error.toString()}'));
                      });
                });
              },
              style: buttonStyle,
              child: const Text("SignOut"),
            ),
          )
        ],
      ),
    );
  }
}
