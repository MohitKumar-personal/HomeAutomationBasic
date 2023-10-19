import 'package:flutter/material.dart';

void main() {
  runApp(SmartHome());
}

class SmartHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget{

  var emailAddress = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('LoginPage'),
      // ),
      body: Container(
          child: Column(
            children: [

              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('Welcome', style: TextStyle(
                              fontSize: 40,
                              color: Colors.white
                            ),),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Sign in to continue', style: TextStyle(
                                fontSize: 25,
                                color: Colors.white
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: Text('Email address', style: TextStyle(
                                fontSize: 18,
                                color: Colors.blue
                              ),),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: TextField(
                            controller: emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email address',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2
                                  )
                              ),
                              prefixIcon: Icon(Icons.email, color: Colors.blue, ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5.0),
                              child: Text('Password',style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blue
                              ),),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: password,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey,
                                      width: 2
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2
                                  )
                              ),
                              prefixIcon: Icon(Icons.password, color: Colors.blue, ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye, color: Colors.blue,),
                                onPressed: () {
                                  print('Icon pressed');
                                },),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 45,
                                child: ElevatedButton(onPressed: (){
                                  String emailaddr = emailAddress.text.toString();
                                  String pass =   password.text;
                                  print("Email: $emailaddr, Password: $pass");
                                }, child: Text('Login'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Sign up', style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue
                                ),),

                            Text('Forgot Password',style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue
                                ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),


            ],
        ),
      )
    );
  }
}
