import 'package:clubapp_project/pages/activity_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clubapp_project/widget/user_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:clubapp_project/pages/List_of_registrants.dart';
// import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class Register_Activity_Screen extends StatefulWidget {
  @override
  _Register_Activity_ScreenState createState() =>
      _Register_Activity_ScreenState();
}

class _Register_Activity_ScreenState extends State<Register_Activity_Screen> {
  late Future<List<dynamic>> futureActivities;

  void initState() {
    super.initState();
    futureActivities = fetchData();
  }

  Future<List<dynamic>> fetchData() async {
    final Uri url =
        Uri.parse('http://127.0.0.182/api_club_app/show_Activity.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      throw Exception('Failed to load data');
    }
  }

  final LocalStorage storage = LocalStorage('user_profile');

  Future<void> registerActivity(
      User_Provider userProvider, String activity) async {
    final String apiUrl =
        'http://127.0.0.182/api_club_app/show_Register_Activity.php';

    try {
      await storage.ready;
      // Get mb_id from LocalStorage
      final Map<String, dynamic>? userData = storage.getItem('user_profile');
      final String? mbId = userData?['userId'];

      if (mbId == null) {
        print('Error: mb_id not found in LocalStorage.');
        return;
      }

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mb_id': mbId, // Use mbId retrieved from LocalStorage
          'act_id': activity, // Use the provided activity
        }),
      );

      // Decode JSON response
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        // Handle success
      } else {
        print(
            'Failed to register activity. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
    }
  }

  Future<bool> checkRegisterActivity(
      User_Provider userProvider, String activity) async {
    final String apiUrl =
        'http://127.0.0.182/api_club_app/show_Check_Register_Activity.php';

    try {
      await storage.ready;
      // Get mb_id from LocalStorage
      final Map<String, dynamic>? userData = storage.getItem('user_profile');
      final String? mbId = userData?['userId'];

      if (mbId == null) {
        print('Error: mb_id not found in LocalStorage.');
        return false; // ส่งค่าเป็น false เพื่อบ่งชี้ว่ามีข้อผิดพลาดเกิดขึ้น
      }

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mb_id': mbId, // Use mbId retrieved from LocalStorage
          'act_id': activity, // Use the provided activity
        }),
      );

      // Decode JSON response
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        // Extract status from responseData and return it
        return responseData['status'];
      } else {
        print(
            'Failed to register activity. Status code: ${response.statusCode}');
        return false; // ส่งค่าเป็น false เพื่อบ่งชี้ว่ามีข้อผิดพลาดเกิดขึ้น
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
      return false; // ส่งค่าเป็น false เพื่อบ่งชี้ว่ามีข้อผิดพลาดเกิดขึ้น
    }
  }

  Future<bool> checkMaxRegisterActivity(String activity) async {
    final String apiUrl =
        'http://127.0.0.182/api_club_app/show_Check_Total_Register_Activity.php';

    try {
      await storage.ready;

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'act_id': activity, // Use the provided activity
        }),
      );

      // Decode JSON response
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print('Response Data: $responseData');
        // Extract status from responseData and return it
        return responseData['status'];
      } else {
        print(
            'Failed to register activity. Status code: ${response.statusCode}');
        return false; // ส่งค่าเป็น false เพื่อบ่งชี้ว่ามีข้อผิดพลาดเกิดขึ้น
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
      return false; // ส่งค่าเป็น false เพื่อบ่งชี้ว่ามีข้อผิดพลาดเกิดขึ้น
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assate/images/regis_01.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      15.0, 150.0, 10.0, 0.0),
                  child: Text(
                    'รายการกิจกรรม',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                const Divider(
                  height: 5,
                  thickness: 1,
                  indent: 11,
                  endIndent: 10,
                  color: Colors.green,
                ),
                FutureBuilder<List<dynamic>>(
                  future: futureActivities,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return buildActivityCard(snapshot.data![index]);
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActivityCard(Map<String, dynamic> activity) {
    DateTime startDateTime = DateTime.parse(activity['start_datetime']);
    DateTime endDateTime = DateTime.parse(activity['end_datetime']);
    DateTime now = DateTime.now();
    bool canRegister = now.isAfter(startDateTime) && now.isBefore(endDateTime);

    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Color.fromRGBO(255, 255, 255, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: Colors.green, width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assate/images/act_03.png',
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity['act_name'] ?? '',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    height: 2,
                                  ),
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'Location: ${activity['act_location'] ?? ''}\n',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    height: 0.8,
                                  ),
                                ),
                                Text(
                                  'Date: ${activity['date_start'] ?? ''} - ${activity['date_end'] ?? ''}\n',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                    height: 0.8,
                                  ),
                                ),
                                Text(
                                  'Registrations: ${activity['act_current_registrations'] ?? ''}',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 13,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Activity_Details_Screen(
                                          actId: activity['act_id'],
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    fixedSize: Size(150, 20),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Icon(
                                          Icons.info_outline,
                                          color: Colors.grey[400],
                                          size: 20,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Text(
                                          'รายละเอียดกิจกรรม',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 2, 10),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListOfRegistrants(
                                        actId: activity['act_id']),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(50, 40)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                              ),
                              child: Text(
                                'รายชื่อผู้ลงทะเบียน',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 2),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                            child: ElevatedButton(
                              onPressed: canRegister
                                  ? () async {
                                      try {
                                        bool registrationStatus =
                                            await checkRegisterActivity(
                                                User_Provider(),
                                                activity['act_id']);
                                        print(
                                            'Registration Status: $registrationStatus');

                                        if (registrationStatus) {
                                          bool maxStatus =
                                              await checkMaxRegisterActivity(
                                                  activity['act_id']);
                                          print('Max Status: $maxStatus');

                                          if (maxStatus) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("การลงทะเบียน"),
                                                  content: Text(
                                                      "คุณต้องการลงทะเบียนหรือไม่"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text("ยืนยัน"),
                                                      onPressed: () async {
                                                        await registerActivity(
                                                            User_Provider(),
                                                            activity['act_id']);
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "การลงทะเบียน"),
                                                              content: Text(
                                                                  "การลงทะเบียนสำเร็จ"),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  child: Text(
                                                                      "ตกลง"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text("ยกเลิก"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("การลงทะเบียน"),
                                                  content: Text(
                                                      "กิจกรรมนี้เต็มแล้ว ขอบคุณที่สนใจ"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text("ตกลง"),
                                                      onPressed: () async {
                                                        await registerActivity(
                                                            User_Provider(),
                                                            activity['act_id']);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("การลงทะเบียน"),
                                                content: Text(
                                                    "คุณได้ลงทะเบียนกิจกรรมนี้แล้ว"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text("ตกลง"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  : null,
                              style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(50, 40)),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.grey;
                                    }
                                    return Colors.black;
                                  },
                                ),
                              ),
                              child: Text(
                                'ลงทะเบียน',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
