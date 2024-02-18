import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class activity_results_screen1 extends StatefulWidget {
  @override
  _activity_results_screen1State createState() =>
      _activity_results_screen1State();
}

class _activity_results_screen1State extends State<activity_results_screen1> {
  late Future<dynamic> futureActivity;
  final LocalStorage storage = LocalStorage('user_profile');
  int total = 0;

  @override
  void initState() {
    super.initState();
    futureActivity = registerActivity('act_id');
    calculateTotal();
  }

  void calculateTotal() async {
    List<dynamic> campData = await futureActivity;

    // บวกค่า credit ของแต่ละกิจกรรมเพื่อหาค่า total
    for (var data in campData) {
      int credit = data['act_credit'];
      total += credit;
    }

    setState(() {}); // อัพเดต UI หลังจากคำนวณค่า total เสร็จ
  }

  Future<dynamic> registerActivity(String activity) async {
    final String apiUrl =
        'http://127.0.0.182/api_club_app/show_User_Activity1.php';

    try {
      await storage.ready;
      // Get mb_id from LocalStorage
      final Map<String, dynamic>? userData = storage.getItem('user_profile');
      final String? mbId = userData?['userId'];

      if (mbId == null) {
        print('Error: mb_id not found in LocalStorage.');
        return 'Error: mb_id not found in LocalStorage.';
      }

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mb_id': mbId, // Use mbId retrieved from LocalStorage
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['camp_data'];
      } else {
        print('Unexpected data format');
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
      return 'Exception occurred: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ผลรวมหน่วยกิตกิจกรรม'),
        ),
        body: Column(
          children: [
            SizedBox(height: 2), // ระยะห่างด้านบน
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(15),
              height: 150,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.orange),
              ),
              child: Column(
                children: [
                  SizedBox(
                      height: 5), // ระยะห่างระหว่าง Text แรกกับ Text ที่สอง
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'รายการ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'ทั้งหมด',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 5), // ระยะห่างระหว่าง Text แรกกับ Text ที่สอง
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'หน่วยกิตของฉัน',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold, // ให้ตัวหนา
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20), // ปรับระยะห่างระหว่าง Padding
                        child: Text(
                          '$total',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold, // ให้ตัวหนา
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'หน่วยกิต',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold, // ให้ตัวหนา
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      height: 15), // ระยะห่างระหว่าง Text แรกกับ Text ที่สอง
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // จัดให้อยู่ตรงกลาง
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'ชมรมอนุรักษ์ธรรมชาติเเละสิ่งเเวดล้อม',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 2), // ระยะห่างระหว่าง Box กับ Text
            Text(
              'รายการกิจกรรมที่เข้าร่วม',
              // textAlign: TextAlign.left, // ระบุ textAlign เป็น TextAlign.left
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                // decoration: TextDecoration.underline, // เพิ่มเส้นใต้
                // decorationColor: Colors.red, // สีของเส้นใต้
                // decorationThickness: 2, // ความหนาของเส้นใต้
                // decorationStyle: TextDecorationStyle.solid, // ความยาวของเส้นใต้
              ),
            ),
            const Divider(
              height: 5,
              thickness: 1,
              indent: 11,
              endIndent: 10,
              color: Colors.grey,
            ),

            SizedBox(height: 2), // ระยะห่างระหว่าง Box กับ FutureBuilder
            Expanded(
              child: FutureBuilder<dynamic>(
                future: futureActivity,
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
                    List<dynamic> campData = snapshot.data;

                    return ListView.builder(
                      itemCount: campData.length,
                      itemBuilder: (context, index) {
                        return buildActivityCard(campData[index]);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildActivityCard(Map<String, dynamic> acData) {
    String name = acData['act_name'] ?? '';
    String location = acData['act_location'] ?? '';
    String year = acData['act_year']?.toString() ?? '';
    int credit = acData['act_credit'] ?? 0;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.green,
          width: 1,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // สีพื้นหลังของ Card
          borderRadius: BorderRadius.circular(15), // โค้งขอบของ Card
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
                    'assate/images/act_03.png', // เปลี่ยนเป็น path ของรูปภาพที่ต้องการแสดงใน Card
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Name: $name\n'
                      'Location: $location\n'
                      'Date: $year\n'
                      'Registrations: $credit',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
