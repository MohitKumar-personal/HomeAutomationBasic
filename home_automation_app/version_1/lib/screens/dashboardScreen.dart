import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});

  final user= FirebaseAuth.instance.currentUser!;

  // Sign out User Method
  void signOutUser(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: signOutUser,
              icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
          child: Text(
              'Logged In As: ' + user.email!,
            style: TextStyle(fontSize: 20),
          )
      ),
    );
  }
}
