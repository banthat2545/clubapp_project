import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clubapp_project/widget/user_provider.dart';
import 'package:provider/provider.dart';

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
        Uri.parse('http://192.168.1.198/api_club_app/show_Activity.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body)['response'];
    } else {
      throw Exception('Failed to load data');
    }
  }

String _actId = ''; // สร้างตัวแปร global เพื่อเก็บค่า actId

Future<void> registerActivity(User_Provider userProvider) async {
    final String apiUrl = 'http://192.168.1.198/api_club_app/show_Register_Activity.php';

    // Get mb_id from User_Provider
    final String mbId = userProvider.loggedInCustomer.memberID;

    try {
      // Using http package
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mb_id': mbId,
          'act_id': _actId, // ใช้ค่า actId ที่ได้จากการดึงข้อมูลกิจกรรม
        }),
      );

      // Decode JSON response
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Handle success
        print(responseData);
      } else {
        // Handle error
        print('Failed to register activity: ${responseData['message']}');
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
            ElevatedButton(
              onPressed: () {
                User_Provider userProvider =
                    Provider.of<User_Provider>(context, listen: false);
                registerActivity(userProvider);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // กำหนดสีพื้นหลังของปุ่มเป็นสีดำ
              ),
              child: Text(
                'ลงทะเบียน',
                style: TextStyle(
                  color: Colors.white, // กำหนดสีของตัวหนังสือเป็นสีขาว
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
