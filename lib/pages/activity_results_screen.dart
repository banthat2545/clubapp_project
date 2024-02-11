import 'dart:convert';
import 'package:clubapp_project/widget/app_text.dart';
import 'package:clubapp_project/widget/back_button.dart';
import 'package:clubapp_project/widget/member_modal.dart';
import 'package:clubapp_project/widget/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Activity_Results_Screen extends StatefulWidget {
  const Activity_Results_Screen({Key? key}) : super(key: key);

  @override
  State<Activity_Results_Screen> createState() =>
      _Activity_Results_ScreenState();
}

class _Activity_Results_ScreenState extends State<Activity_Results_Screen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  Future<Map<String, dynamic>> fetchUserData(
      BuildContext context, String mbId) async {
    final apiUrl = 'http://192.168.1.198/api_club_app/show_User_Activity.php';
    final userProvider = Provider.of<User_Provider>(context,
        listen: false); // เปลี่ยนเป็น URL ของ API ของคุณ
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({'mb_id': userProvider.getUserId()});

    final response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      // เรียกใช้งาน UserProvider จาก Provider
      userProvider.setLoggedInCustomer(Member(
        memberID: data['member_info']['mb_id'],
        membername: data['member_info']['mb_name'],
        memberEmail: data['member_info']['mb_email'],
        memberTel: data['member_info']['mb_tel'],
      ));
      userProvider.setUserId(data['member_info']['mb_id']);

      return data;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> activityTypeData =
        []; // ประกาศตัวแปร activityTypeData ในส่วนที่ต้องการใช้งาน
    TabController _tabController = TabController(length: 1, vsync: this);
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Back
            Container(
              child: Row(
                children: [
                  // Icon(Icons.menu, size: 30, color: Colors.black54),
                  Expanded(child: Container()),
                  Container(
                    child: BackButtonWidget(),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 5,
            ),

            //discover text หัวข้อ
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: AppText(
                text: "ผลกิจกรรม",
                size: 25,
              ),
            ),

            SizedBox(
              height: 5,
            ),

            //หน่วยกิตรวม
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),

            //tabber แถบเมนู วัน สัปดาห์ เดือน

            SizedBox(
              height: 5,
            ),

            Container(
              margin: const EdgeInsets.only(left: 15),
              child: AppText(
                text: "รายการเข้าร่วมกิจกรรม",
                size: 20,
              ),
            ),

            //ช่องใส่ข้อมูลแต่ละหน้า
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              height: 160,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    itemCount: activityTypeData
                        .length, // ใช้ความยาวของ activityTypeData เพื่อกำหนดจำนวนของไอเท็ม
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      // ดึงข้อมูลจาก activityTypeData โดยใช้ index
                      var activityType = activityTypeData[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 15, top: 10),
                        width: 330,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromARGB(255, 45, 212, 51),
                            width: 1.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Activity ID: ${activityType['act_id']}'), // แสดง act_id
                            Text(
                                'Activity Name: ${activityType['act_name']}'), // แสดง act_name
                            Text(
                                'Activity Year: ${activityType['act_year']}'), // แสดง act_year
                            Text(
                                'Activity Credit: ${activityType['act_credit']}'), // แสดง act_credit
                            Text(
                                'Activity Total Max: ${activityType['act_total_max']}'), // แสดง act_total_max
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   Widget buildActivityCard(Map<String, dynamic> activity) {
//     return FutureBuilder<Map<String, dynamic>>(
//       future: fetchUserData(
//           context,
//           activity[
//               'mb_id']), // เรียกใช้ Future fetchUserData ด้วย mb_id ของกิจกรรม
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // หากกำลังโหลดข้อมูล จะแสดง Indicator หรืออะไรก็ตาม
//           return CircularProgressIndicator(); // เปลี่ยนเป็น Indicator ที่คุณต้องการ
//         } else if (snapshot.hasError) {
//           // หากเกิดข้อผิดพลาดในการโหลดข้อมูล
//           return Text('Error: ${snapshot.error}');
//         } else {
//           // หากโหลดข้อมูลเสร็จสมบูรณ์ จะสร้าง Card โดยใช้ข้อมูลที่ได้จาก Future fetchUserData
//           Map<String, dynamic> userData =
//               snapshot.data ?? {}; // ดึงข้อมูลที่ได้จาก Future
//           return Card(
//             color: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15),
//               side: BorderSide(color: Colors.green, width: 1),
//             ),
//             child: ListTile(
//               leading: Image.asset(
//                 'assate/images/act_03.png',
//                 fit: BoxFit.cover,
//                 width: 100,
//                 height: 170,
//               ),
//               title: Text(
//                 activity['act_name'] ?? '',
//                 style: TextStyle(
//                   color: Colors.red,
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 'Location: ${activity['act_location'] ?? ''}\n'
//                 'Date: ${activity['date_start'] ?? ''} - ${activity['date_end'] ?? ''}\n'
//                 'Registrations: ${activity['act_current_registrations'] ?? ''}\n'
//                 'User Name: ${userData['membername'] ?? ''}\n' // แสดงชื่อผู้ใช้จากข้อมูลที่ได้จาก Future
//                 'User Email: ${userData['memberEmail'] ?? ''}\n' // แสดงอีเมลผู้ใช้จากข้อมูลที่ได้จาก Future
//                 'User Tel: ${userData['memberTel'] ?? ''}', // แสดงเบอร์โทรศัพท์ผู้ใช้จากข้อมูลที่ได้จาก Future
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 14,
//                 ),
//               ),
//               trailing: ElevatedButton(
//                 onPressed: () {
//                   // ระบุการดำเนินการเมื่อปุ่มถูกกด
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.black,
//                 ),
//                 child: Text(
//                   'ลงทะเบียน',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
