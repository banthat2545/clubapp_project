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

  Future<void> registerActivity(User_Provider userProvider, String activity) async {
  final String apiUrl = 'http://127.0.0.182/api_club_app/show_Register_Activity.php';

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
      print('Failed to register activity. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exception
    print('Exception occurred: $e');
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
    return Card(
      color: Colors.white, // กำหนดสีของ Card
      shape: RoundedRectangleBorder(
        // เพิ่มเส้นขอบให้กับ Card
        borderRadius: BorderRadius.circular(15), // กำหนดรูปร่างของเส้นขอบ
        side: BorderSide(
            color: Colors.green, width: 1), // กำหนดสีและความหนาของเส้นขอบ
      ),
      child: ListTile(
        leading: Image.asset(
          'assate/images/act_03.png', // ตำแหน่งของรูปภาพภายในโปรเจค
          fit: BoxFit.cover,
          width: 100, // กำหนดความกว้างของรูปภาพ
          height: 170,
        ), // กำหนดความสูงของรูปภาพ
        title: Text(
          activity['act_name'] ?? '',
          style: TextStyle(
            color: Colors.red, // กำหนดสีของตัวอักษรเป็นสีแดง
            fontSize: 10, // กำหนดขนาดของตัวอักษรเป็น 18
            fontWeight: FontWeight.bold, // กำหนดตัวหนาของตัวอักษร
          ),
        ),
        subtitle: Text(
          'Location: ${activity['act_location'] ?? ''}\n'
          'Date: ${activity['date_start'] ?? ''} - ${activity['date_end'] ?? ''}\n'
          'Registrations: ${activity['act_current_registrations'] ?? ''}',
          style: TextStyle(
            color: Colors.blue, // กำหนดสีของตัวอักษรเป็นสีน้ำเงิน
            fontSize: 14, // กำหนดขนาดของตัวอักษรเป็น 14
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween, // จัดการตำแหน่งของปุ่มและ

          // mainAxisAlignment: MainAxisAlignment.spaceBetween, // จัดการตำแหน่งของปุ่มและข้อความ
          crossAxisAlignment:
              CrossAxisAlignment.end, // จัดการตำแหน่งให้ปุ่มไหลลงมา
          children: [
            // Text('Registrations: ${activity['act_current_registrations'] ?? ''}'),
            SizedBox(width: 1), // เพิ่มระยะห่างระหว่างปุ่มและข้อความ
            //เรียกใช้งานฟังก์ชัน registerActivity เมื่อผู้ใช้คลิกที่ปุ่ม "ลงทะเบียน"
            ElevatedButton(
              onPressed: () async {
                try {
                  // เรียกใช้งานฟังก์ชัน registerActivity เพื่อลงทะเบียนกิจกรรม
                  await registerActivity(User_Provider(), activity['act_id']);
                  // กระทำตามลำดับถัดไปหลังจากลงทะเบียนกิจกรรมสำเร็จ
                } catch (e) {
                  // จัดการกับข้อผิดพลาดในการลงทะเบียนกิจกรรม
                  print('Failed to register activity: $e');
                }
              },
              child: Text('ลงทะเบียนกิจกรรม'),
            ),
          ],
        ),
      ),
    );
  }
}
