import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class ListOfRegistrants extends StatefulWidget {
  final String actId;

  const ListOfRegistrants({Key? key, required this.actId}) : super(key: key);

  @override
  _ListOfRegistrantsState createState() => _ListOfRegistrantsState();
}

class _ListOfRegistrantsState extends State<ListOfRegistrants> {
  late Future<dynamic> futureActivity;
  final LocalStorage storage = LocalStorage('user_profile');
  int total = 0;
  late Future<dynamic> futureDetailsActivity;

  @override
  void initState() {
    super.initState();
    futureActivity = fetchRegisterActivities(widget.actId);
    futureDetailsActivity = fetchActivities(widget.actId);
  }

  Future<dynamic> fetchRegisterActivities(String actId) async {
    final apiUrl =
        'http://127.0.0.182/api_club_app/show_List__Of_Registrants.php';

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

  Future<dynamic> fetchActivities(String actId) async {
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0),
                child: Text('ข้อมูลกิจกรรมกิจกรรม'),
              ),
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
            children: [
              SizedBox(height: 2),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assate/images/act_03.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: FutureBuilder<dynamic>(
                        future: futureDetailsActivity,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else {
                            List<dynamic> activities =
                                snapshot.data['response'];
                            return SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: activities.map((activity) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'ชื่อกิจกรรม : ',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: '${activity['act_name']}',
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'ปีที่จัดกิจกรรม : ${activity['act_year']}',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        'จำนวนหน่วยกิต : ${activity['act_credit']}',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        'วันที่เริ่มจัด : ${activity['date_start']}',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        'วันที่สิ้นสุด : ${activity['date_end']}',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        'สถานที่ : ${activity['act_location']}',
                                        style: TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                'รายชื่อผู้เข้าร่วมกิจกรรม',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 2),
              const Divider(
                height: 5,
                thickness: 1,
                indent: 30,
                endIndent: 30,
                color: Colors.green,
              ),
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
                      List<dynamic> activities = snapshot.data['response'];

                      return DataTable(
                        columnSpacing: 10,
                        horizontalMargin: 20,
                        columns: [
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 2),
                              child: Text(
                                'ลำดับที่',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 2),
                              child: Text(
                                'รหัสนักศึกษา',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 1, vertical: 2),
                              child: Text(
                                'ชื่อ-สกุล',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                        rows: activities.map<DataRow>((activity) {
                          int index = activities.indexOf(activity) + 1;
                          return DataRow(
                            cells: [
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(index.toString()),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(activity['mb_id'].toString()),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Text(activity['mb_name']),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
