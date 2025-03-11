import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hashcovet_machine_test/constants/constants.dart';
import 'package:hashcovet_machine_test/constants/customColors.dart';
import 'package:hashcovet_machine_test/dashboard.dart';
import 'package:hashcovet_machine_test/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final _auth = FirebaseAuth.instance;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              shrinkWrap: true,
              children: [
                Text(
                  "LOGIN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: customTextColor,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                TextField(
                  controller: _emailController,
                  decoration: inputDecoration('Email', Icons.mail),
                ),
                SizedBox(height: size.height * 0.02),
                TextField(
                    controller: _passwordController,
                    decoration: inputDecoration(
                        'Password', Icons.lock_outline_rounded)),
                SizedBox(height: size.height * 0.02),
                ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: _emailController.text,
                              password: _passwordController.text)
                          .then((value) {
                        Navigator.push(context, navigatorToDashboard);
                      }).onError((error, stackTrace) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  content: Text(
                                      'Wrong input\nError:${error.toString()}'));
                            });
                      });
                    },
                    style: buttonStyle,
                    child: const Text("login")),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      child: const Divider(
                        endIndent: 10,
                      ),
                    ),
                    const Text("Or"),
                    SizedBox(
                        width: size.width * 0.4,
                        child: const Divider(
                          indent: 10,
                        )),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                      onTap: () async {
                        try {
                          final googleUser = await GoogleSignIn().signIn();
                          final googleAuth = await googleUser?.authentication;
                          final cred = GoogleAuthProvider.credential(
                              idToken: googleAuth?.idToken,
                              accessToken: googleAuth?.accessToken);
                          _auth.signInWithCredential(cred).then((value) {
                            Navigator.push(context, navigatorToDashboard);
                          }).onError((error, stackTrace) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const AlertDialog(
                                      content: Text('Something went wrong'));
                                });
                          });
                        } catch (e) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content: Text("Something went wrong !")));
                          log(e.toString());
                        }
                      },
                      child: Image.asset('assets/google_icon.png',
                          height: 30, width: 30)),
                  const SizedBox(width: 50),
                  GestureDetector(
                      onTap: () async {
                        try {
                          // UserCredential userCredential =
                          await SignInWithGithub();
                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()));
                          }
                        } catch (e) {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content: Text("Something went wrong !")));
                          log(e.toString());
                        }
                      },
                      child: Image.asset('assets/github_icon.png',
                          height: 30, width: 30)),
                ]),
                SizedBox(height: size.height * 0.02),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: customTextColor, fontSize: 14),
                        children: [
                          const TextSpan(text: 'Don\'t you have an account ?'),
                          TextSpan(
                              text: '  Sign up ',
                              style: TextStyle(
                                  color: customLinkTextColor, fontSize: 15),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  const CircularProgressIndicator();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage(),
                                      ));
                                  log('login', name: 'login');
                                }),
                        ]))
              ]),
        ),
      ),
    );
  }
}

Future<UserCredential> SignInWithGithub() async {
  GithubAuthProvider githubAuthProvider = GithubAuthProvider();
  return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
}
