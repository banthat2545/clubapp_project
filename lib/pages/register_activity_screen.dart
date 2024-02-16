import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clubapp_project/widget/user_provider.dart';
import 'package:localstorage/localstorage.dart';
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('รายการกิจกรรม'),
        ),
        body: FutureBuilder<List<dynamic>>(
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
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return buildActivityCard(snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildActivityCard(Map<String, dynamic> activity) {
    DateTime startDateTime = DateTime.parse(activity['start_datetime']);
    DateTime endDateTime = DateTime.parse(activity['end_datetime']);
    DateTime now = DateTime.now();
    bool canRegister = now.isAfter(startDateTime) && now.isBefore(endDateTime);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Color.fromRGBO(255, 255, 255, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.green, width: 1.5),
      ),
      child: Row(children: [
        // Column 1: Image
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // ปรับความโค้งของขอบรูป
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
              // Row แรก: ข้อความทั้งหมด
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['act_name'] ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            height: 2, // ตั้งค่าระยะห่างระหว่างบรรทัด
                          ),
                        ),
                        SizedBox(
                            height:
                                1), // ปรับระยะห่างระหว่างบรรทัดเป็น 4 พิกเซล
                        Text(
                          'Location: ${activity['act_location'] ?? ''}\n',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
                          ),
                        ),
                        Text(
                          'Date: ${activity['date_start'] ?? ''} - ${activity['date_end'] ?? ''}\n',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
                          ),
                        ),
                        Text(
                          'Registrations: ${activity['act_current_registrations'] ?? ''}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            // height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
                          ),
                        ),
                        Text(
                          'Registrations: ${activity['start_datetime'] ?? ''}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            // height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
                          ),
                        ),
                        Text(
                          'Registrations: ${activity['end_datetime'] ?? ''}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 13,
                            // height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Your code here
                          },
                          style: TextButton.styleFrom(
                            fixedSize: Size(150, 20), // กำหนดขนาดคงที่ของปุ่ม
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 0),
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors
                                      .grey[400], // เลือกค่าสีเทาที่คุณต้องการ
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
                                    color: Colors.grey[
                                        500], // เลือกค่าสีเทาที่คุณต้องการ
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
              SizedBox(height: 5), // ปรับระยะห่างระหว่าง Row แรกและ Row ที่สอง
              // Row ที่สอง: ปุ่ม
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 2, 10),
                    child: ElevatedButton(
                      onPressed: () {
                        // Your code here
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(50, 40)),
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
                  SizedBox(width: 2), // ปรับระยะห่างระหว่างปุ่ม
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                    child: ElevatedButton(
                      onPressed: canRegister
                          ? () async {
                              final Map<String, dynamic>? userData =
                                  storage.getItem('user_profile');
                              final String? mbId = userData?['userId'];
                              try {
                                // เรียกใช้ checkRegisterActivity
                                bool registrationStatus =
                                    await checkRegisterActivity(
                                        User_Provider(), activity['act_id']);

                                if (registrationStatus) {
                                  bool MaxStatus =
                                      await checkMaxRegisterActivity(
                                          activity['act_id']);
                                  if (MaxStatus) {
                                    print(
                                        'ทำการยืนยังการลงทะเบียนค่า ไปกันต่อ');
                                    print('ยังไม่เต็มค่า ไปกันต่อ');
                                  } else {
                                    print('แจ้งว่าเต็มแล้วค่า ไปกันต่อ');
                                  }
                                } else {
                                  print('แจ้งว่าลงทะเบียนแล้วค่า ไปกันต่อ');
                                }
                              } catch (e) {
                                print(e);
                              }
                            }
                          : null,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(50, 40)),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors
                                .grey; // ให้เป็นสีเทาเมื่อปุ่มไม่สามารถกดได้
                          }
                          return Colors
                              .black; // ให้เป็นสีดำเมื่อปุ่มสามารถกดได้
                        }),
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
      ]),
    );
  }
}
