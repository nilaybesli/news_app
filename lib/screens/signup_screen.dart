import 'package:flutter/material.dart';
import 'package:news_app/newsList.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/login_screen.dart';

import '../resources/auth_methods.dart';
import '../resources/firestore_methods.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
    );

    if (res != 'success') {
      // showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen(news: FirestoreMethods().getNewsFromFirestore())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Register",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                icon: Icon(
                  Icons.email,
                ),
              ),
            ),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                icon: Icon(
                  Icons.person,
                ),
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 250,
              height: 45,
              child: ElevatedButton(
                onPressed: signUpUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.3),
                ),
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).primaryColor.withOpacity(0.4),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
