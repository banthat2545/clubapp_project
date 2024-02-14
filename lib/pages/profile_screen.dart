import 'package:clubapp_project/widget/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import 'dart:convert';
import 'dart:convert';

class profile_Screen extends StatefulWidget {
  @override
  State<profile_Screen> createState() => _profile_ScreenState();
}

class _profile_ScreenState extends State<profile_Screen> {
  late Future<Map<String, dynamic>> profile;
  late String id;
  late String name;
  late String email;
  late String tell;

  @override
  void initState() {
    super.initState();
    id = "";
    name = "";
    email = "";
    tell = "";
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final url = Uri.parse('http://127.0.0.182/api_club_app/showUser.php');
    final userProvider = Provider.of<User_Provider>(context, listen: false);
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'mb_id': userProvider.getUserId()
        }), // เรียกใช้ค่า id จาก UserProvider
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        // json.decode(utf8.decode(response.bodyBytes));
        final Map<String, dynamic> userData = data['data'];

        String Memberid = userData['mb_id'] ?? '';
        String MemberName = userData['mb_name'] ?? '';
        String Memberemail = userData['mb_email'] ?? '';
        String Membertell = userData['mb_tel'] ?? '';

        setState(() {
          id = Memberid;
          name = MemberName;
          email = Memberemail;
          tell = Membertell;
        });
      } else {
        print('Unexpected data format');
      }
    } catch (error) {
      print('Error loading user profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // CircleAvatar(
            //   radius: 70,
            //   backgroundImage: AssetImage(''),
            // ),
            const SizedBox(height: 10),
            itemProfile('ID', id, CupertinoIcons.home),
            const SizedBox(height: 10),
            itemProfile('Name', name, CupertinoIcons.person),
            const SizedBox(height: 10),
            itemProfile('Email', email, CupertinoIcons.mail),
            const SizedBox(height: 10),
            itemProfile('tell', tell, CupertinoIcons.phone),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.blueAccent.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.grey,
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
