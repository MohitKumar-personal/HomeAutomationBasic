import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:version_1/components/mybutton.dart';
import 'package:version_1/components/mytextfields.dart';
import 'package:version_1/screens/forgot_passwordScreen.dart';

import '../components/square_tile.dart';

class LoginScreen extends StatefulWidget{
  final Function()? onTap;
  const LoginScreen({super.key, required this.onTap});
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //text editing controller
  final emailidController = TextEditingController();
  final passwordController = TextEditingController();

  //USER SIGN IN METHOD
  void signUserIn() async{
    // Show Loading Circle
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    // Try Sign In
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailidController.text,
        password: passwordController.text,
      );
      //Pop the Loading Circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      //Pop the Loading Circle
      Navigator.pop(context);

      // Show Error Message
      showErrorMessage(error.code);

    }

  }

// SHOW ERROR MESSAGE TO USER
  void showErrorMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )
          ),
        ),
        backgroundColor: Color(0xffd30001),
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 120,
            left: 25,
            right: 25
        ),


      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //BHARAT INNOVATION LOGO
                const SizedBox(height: 50,),
                SizedBox(
                  height: 300, width: double.infinity,
                    child: Image.asset('assets/images/logo/bharatinnovationlogo.png')),

                //WELCOME BACK, YOU'VE BEEN MISSED
                const Text('Welcome back, you\'ve been missed',
                  style: TextStyle(
                    color: Color(0xff2A5794),
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                const SizedBox(height: 25,),

                // INPUT EMAIL ADDRESS TEXTFIELD
                MyTextField(
                  controller: emailidController,
                  hintText: 'Please enter your email',
                  obscureText: false,
                ),
                const SizedBox(height: 10,),
                //INPUT PASSWORD TEXTFIELD
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10,),

                //FORGET PASSWORD FIELD OR TEXT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(),
                              ));
                        },
                        child: const Text('Forget Password?',
                          style: TextStyle(
                              color: Color(0xff2A5794),
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),

                //SIGN IN BUTTON LAYOUT
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                  buttonColor: const Color(0xffd30001),
                  buttonTextColor: Colors.white,
                ),
                const SizedBox(height: 25,),

                //AUTHENTICATION BUTTON LIKE GOOGLE AND APPLE ID
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: Divider(
                //             thickness: 0.5,
                //             color: Colors.grey[400],
                //           )
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text('Or continue with', style: TextStyle(
                //           color: Colors.grey[700],
                //         ),),
                //       ),
                //       Expanded(
                //           child: Divider(
                //             thickness: 0.5,
                //             color: Colors.grey[400],
                //           )
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 50,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SquareTile(imagePath: 'assets/images/logo/google.png'),
                //     SizedBox(width: 25,),
                //     SquareTile(imagePath: 'assets/images/logo/apple.png'),
                //
                //   ],
                // ),
                //
                // SizedBox(height: 50,),

                //NOT A MEMBER ? REGISTER NOW...
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?',
                      style: TextStyle(
                          color: Colors.grey[800],
                        fontSize: 15
                      ),
                    ),
                    const SizedBox(width: 4,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Register Now',
                        style: TextStyle(
                          color: Color(0xff2A5794),
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}