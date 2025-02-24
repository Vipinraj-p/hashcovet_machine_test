import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hashcovet_machine_test/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAKTORvcGCmVAcopZ6iZ3GJ1mJ_4aBioJI',
    appId: 'com.hashcovet.hashcovet_machine_test',
    messagingSenderId: '1034386195948',
    projectId: 'hashcovet-machine-test',
    storageBucket: 'hashcovet-machine-test.firebasestorage.app',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
