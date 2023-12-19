import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:version_1/components/mybutton.dart';
import 'package:version_1/components/mytextfields.dart';

class RegisterScreen extends StatefulWidget{
  final Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});
  @override
  State<StatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  //text editing controller
  final fullnameController = TextEditingController();
  final emailidController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();


  //sign up user method
  Future signUserUp() async{
    // Show Loading Circle
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
    );

    // Try Creating the User
    try{
      // Check if password is confirmed or same
      if(passwordController.text == confirmpasswordController.text) {
        //CREATE USER
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailidController.text,
          password: passwordController.text,
        );

        //ADD USER DETAILS
        addUserDetails(userCredential);

        Navigator.pop(context);

      }
      else {
        //Show Error message that your password is not same or confirmed
        showErrorMessage("Password doesn\'t match !!");
        Navigator.pop(context);
      }
      //Pop the Loading Circle
    } on FirebaseAuthException catch (error) {
      //Pop the Loading Circle
      Navigator.pop(context);
      // Show Error Message
      showErrorMessage(error.code);
    }
  }

  Future addUserDetails(UserCredential? userCredential)  async {
    if (userCredential != null && userCredential.user != null){
      await FirebaseFirestore.instance
          .collection('UsersData')
          .doc(userCredential.user!.email)
          .set({
        'email':userCredential.user!.email,
        'fullname': fullnameController.text,
      })
          .then((value) => print("User Added"))
          .catchError((error) => showErrorMessage(error.code));
    }
  }

  // Error message to User
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
        backgroundColor: const Color(0xffd30001),
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
        child: Container(
          height: double.infinity,
          width: double.infinity,
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

                  //LET'S CREATE AN ACCOUNT FOR YOU!
                  const Text('Let\'s create an account for you!',
                    style: TextStyle(
                        color: Color(0xff2A5794),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 25,),

                  // INPUT FULL NAME TEXTFIELD
                  MyTextField(
                    controller: fullnameController,
                    hintText: 'Full Name',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10,),

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
                  //INPUT CONFIRM PASSWORD TEXTFIELD
                  MyTextField(
                    controller: confirmpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 25,),

                  //SIGN IN BUTTON LAYOUT
                  MyButton(
                    text: 'Sign Up',
                    onTap: signUserUp,
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

                  // REGISTRATION BUTTON OR TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                        style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15
                        ),
                      ),
                      const SizedBox(width: 4,),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text('Login now',
                          style: TextStyle(
                              color: Color(0xff2A5794),
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}