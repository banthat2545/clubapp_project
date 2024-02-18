import 'package:clubapp_project/pages/login_screen.dart';
import 'package:clubapp_project/widget/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import 'dart:convert';
import 'package:localstorage/localstorage.dart'; // Add this import statement
import 'dart:convert';
import 'package:clubapp_project/pages/update_profile.dart';

class profile_Screen extends StatefulWidget {
  @override
  State<profile_Screen> createState() => _profile_ScreenState();
}

final LocalStorage storage = LocalStorage('user_profile');

class _profile_ScreenState extends State<profile_Screen> {
  late Future<Map<String, dynamic>> profile;
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController telController;
  late TextEditingController facultyController;
  late TextEditingController branchController;

  get useredit => null;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    telController = TextEditingController();
    facultyController = TextEditingController();
    branchController = TextEditingController();
    profile = fetchUserProfile(); // กำหนดค่าให้กับ profile ใน initState
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final url = Uri.parse('http://127.0.0.182/api_club_app/showUser.php');
    final userProvider = Provider.of<User_Provider>(context, listen: false);
    try {
      final response = await http.post(
        url,
        body: json.encode({'mb_id': userProvider.getUserId()}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> userData = data['data'];

        String Memberid = userData['mb_id'] ?? '';
        String MemberName = userData['mb_name'] ?? '';
        String Memberemail = userData['mb_email'] ?? '';
        String Membertell = userData['mb_tel'] ?? '';
        String Memberfaculty = userData['faculty_id'] ?? '';
        String Memberbranch = userData['branch_id'] ?? '';

        setState(() {
          idController.text = Memberid;
          nameController.text = MemberName;
          emailController.text = Memberemail;
          telController.text = Membertell;
          facultyController.text = Memberfaculty;
          branchController.text = Memberbranch;
        });

        return data; // ส่งข้อมูลผู้ใช้กลับ
      } else {
        print('Unexpected data format');
        throw Exception('Failed to load user profile');
      }
    } catch (error) {
      print('Error loading user profile: $error');
      throw Exception('Failed to load user profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: profile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final Map<String, dynamic> data =
                  snapshot.data as Map<String, dynamic>;
              final Map<String, dynamic> userData = data['data'];
              String id = userData['mb_id'] ?? '';
              String name = userData['mb_name'] ?? '';
              String email = userData['mb_email'] ?? '';
              String tell = userData['mb_tel'] ?? '';
              String faculty = userData['faculty_name'] ?? '';
              String branch = userData['branch_name'] ?? '';
              return Column(
                children: [
                  SizedBox(height: 10),
                  itemProfile('ID', id, CupertinoIcons.home, 'Your ID'),
                  itemProfile('Name', name, CupertinoIcons.person, 'Your Name'),
                  itemProfile(
                      'Email', email, CupertinoIcons.mail, 'Your Email'),
                  itemProfile(
                      'tell', tell, CupertinoIcons.phone, 'Your Phone Number'),
                  itemProfile(
                      'faculty', faculty, CupertinoIcons.mail, 'Your Email'),
                  itemProfile('branch', branch, CupertinoIcons.phone,
                      'Your Phone Number'),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Update_Profile(mbId: id),
                              ),
                            );
                          },
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
                      SizedBox(height: 150),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ต้องการออกจากระบบหรือไม่?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('ยกเลิก'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await storage.clear();
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Login_Screen(),
                                          ),
                                        );
                                      },
                                      child: Text('ตกลง'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            padding: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget itemProfile(
      String title, String subtitle, IconData iconData, String hintText) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        initialValue: subtitle, // กำหนดค่าเริ่มต้นจาก subtitle
        readOnly: true, // ตั้งค่าให้ไม่สามารถแก้ไขได้
        style: TextStyle(
          color: Colors.green,
          fontFamily: "Maehongson",
        ),
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(
            color: Colors.black38,
            fontSize: 15,
            fontFamily: "Maehongson",
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 3.0),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          hintStyle: TextStyle(
            color: Colors.black26,
            fontSize: 15,
            fontFamily: "Maehongson",
          ),
          hintText: hintText,
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            iconData,
            color: Colors.black26,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        ),
      ),
    );
  }
}
