
import 'package:clubapp_project/pages/profile_screen.dart';
import 'package:clubapp_project/pages/activity_results_screen.dart';
import 'package:clubapp_project/pages/home_screen.dart';
import 'package:clubapp_project/pages/register_activity_screen.dart';
import 'package:flutter/material.dart';
class Options_Screen extends StatefulWidget {
  //const HomeScreen({super.key});

  @override
  State<Options_Screen> createState() => _Options_ScreenState();
}

class _Options_ScreenState extends State<Options_Screen> {
  int currentIndex = 0;
  List widgetOptions = [
    Home_Screen(),
    Register_Activity_Screen(),
    Activity_Results_Screen(),
    profile_Screen(),
    Text("ข้อมูลส่วนตัว"),
  ];
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widgetOptions[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.app_registration_rounded,
                ),
                label: 'register'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assignment_turned_in,
                ),
                label: 'activity'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'person'),
          ]),
    );
  }
}
