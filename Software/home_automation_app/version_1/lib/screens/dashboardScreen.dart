import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:version_1/components/smart_device_box.dart';


class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final user= FirebaseAuth.instance.currentUser!;

  // Sign out User Method
  void signOutUser(){
    FirebaseAuth.instance.signOut();
  }

  // list of smart devices
  List mySmartDevices = [
    // [ smartDeviceName, iconPath , powerStatus ]
    ["Smart Light", "assets/images/icons/lightbulb.png", false],
    ["Smart Light", "assets/images/icons/lightbulb.png", false],
    ["Smart TV", "assets/images/icons/lightbulb.png", false],
    ["Smart Fan", "assets/images/icons/lightbulb.png", false],
  ];

  // power button switched
  void powerSwitchChanged(bool value, int index) {
    setState(() {
      mySmartDevices[index][2] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5fffa),
      body: SafeArea(
        child: Column(
          children: [
            //CUSTOM APP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                vertical: 25,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/icons/menu.png',
                    height: 45,
                    color: Colors.grey[800],
                  ),
                  GestureDetector(
                    onTap: (){
                      signOutUser();
                    },
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),

            //WELCOME HOME USER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Welcome Home',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  Text(
                      'Mohit Kumar',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 72
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                thickness: 1,
                color: Color.fromARGB(255, 204, 204, 204),
              ),
            ),
            const SizedBox(height: 25),

            // SMART DEVICES NAME
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                  'Smart Devices',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10,),

            //SMART DEVICES + GRIDS
            Expanded(
              child: GridView.builder(
                itemCount: 4,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.3,
                  ),
                  itemBuilder: (context, index){
                    return SmartDeviceBox(
                      smartDeviceName: mySmartDevices[index][0],
                      iconPath: mySmartDevices[index][1],
                      powerOn_Off: mySmartDevices[index][2],
                      onChanged: (value) => powerSwitchChanged(value, index),
                    );
                  }
              ),
            ),

          ],
        ),
      ),
    );
  }
}
