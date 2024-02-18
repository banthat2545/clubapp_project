import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Activity_Details_Screen extends StatefulWidget {
  final String actId;

  const Activity_Details_Screen({Key? key, required this.actId})
      : super(key: key);

  @override
  State<Activity_Details_Screen> createState() =>
      _Activity_Details_ScreenState();
}

class _Activity_Details_ScreenState extends State<Activity_Details_Screen> {
  late Future<dynamic> futureActivity;

  @override
  void initState() {
    super.initState();
    futureActivity = fetchRegisterActivities(widget.actId);
  }

  Future<dynamic> fetchRegisterActivities(String actId) async {
    final apiUrl = 'http://127.0.0.182/api_club_app/show_activity_details.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'act_id': actId,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch register activities');
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(255, 255, 255, 0.5), // กำหนดสีโปร่งใส
          title: Row(
            children: [
              Spacer(),
              Material(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    child: Text(
                      "  กลับ  ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: "Maehongson",
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assate/images/detail_02.jpg'), // ตั้งค่ารูปภาพที่จะใช้เป็นพื้นหลัง
              fit: BoxFit
                  .cover, // ให้รูปภาพปรับขนาดเพื่อให้ครอบคลุมพื้นที่ของ Container
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Container(
                  // decoration: const BoxDecoration(
                  //   borderRadius: BorderRadius.all(
                  //     Radius.circular(60),
                  //   ),
                  // ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 30, 8),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "รายละเอียดกิจกรรม",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 25,
                              // fontWeight: FontWeight.w300,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Maehongson",
                            ),
                          ),
                        ),
                        const Divider(
                          height: 5,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              FutureBuilder<dynamic>(
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
                    List<dynamic> activities = snapshot.data['response'];

                    return SingleChildScrollView(
                      child: Column(
                        children: activities.map((activity) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ชื่อกิจกรรม : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['act_name']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'ปีที่จัดกิจกรรม : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['act_year']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'จำนวนหน่วยกิต : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['act_credit']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'จำนวนผู้เข้าร่วมสูงสุด: ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['act_total_max']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'วันที่เริ่มจัดกิจกรรม : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['date_start']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'วันที่สิ้นสุดการจัดกิจกรรม : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['date_end']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'สถานที่ : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['act_location']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'วันที่และเวลาเริ่มลงทะเบียน : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['start_datetime']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text(
                                      'วันที่และเวลาสิ้นสุดการลงทะเบียน : ',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${activity['end_datetime']}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
