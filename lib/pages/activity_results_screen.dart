// import 'dart:convert';
// // import 'package:clubapp_project/widget/app_text.dart';
// // import 'package:clubapp_project/widget/back_button.dart';
// // import 'package:clubapp_project/widget/member_modal.dart';
// // import 'package:clubapp_project/widget/user_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:localstorage/localstorage.dart';

// class Activity_Results_Screen extends StatefulWidget {
//   const Activity_Results_Screen({Key? key}) : super(key: key);

//   @override
//   State<Activity_Results_Screen> createState() =>
//       _Activity_Results_ScreenState();
// }

// class _Activity_Results_ScreenState extends State<Activity_Results_Screen>
//     with TickerProviderStateMixin {
//   TextEditingController searchController = TextEditingController();

//  final LocalStorage storage = LocalStorage('user_profile');
 
//   Future<List<dynamic>> fetchData() async {
//     final Uri url =
//         Uri.parse('http://127.0.0.182/api_club_app/show_Activity.php');
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       return json.decode(response.body)['response'];
//     } else {
//       throw Exception('Failed to load data');
//     }
//   }
//   Future<Map<String, dynamic>> fetchCampData1(String userId) async {
//     final String apiUrl = 'http://127.0.0.1/api_club_app/show_User_Activity1.php';
    
//     try {
//       await storage.ready;
//       // Get mb_id from LocalStorage
//       final Map<String, dynamic>? userData = storage.getItem('user_profile');
//       final String? mbId = userData?['userId'];

//       if (mbId == null) {
//         throw Exception('User ID not found in LocalStorage.');
//       }

//       var response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'mb_id': mbId}),
//       );

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load data from API');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

// // Future<Map<String, dynamic>> fetchCampData2(String userId) async {
// //     final String apiUrl = 'http://127.0.0.1/api_club_app/show_User_Activity13.php';
// //     try {
// //       await storage.ready;

// //       Map<String, String>? userData = storage.getItem('user_profile');
// //       String? mbId = userData?['userId'];

// //       if (mbId == null) {
// //         throw Exception('User ID not found in LocalStorage.');
// //       }

// //       var response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({'mb_id': mbId}),
// //       );

// //       if (response.statusCode == 200) {
// //         return jsonDecode(response.body);
// //       } else {
// //         throw Exception('Failed to load data from API');
// //       }
// //     } catch (e) {
// //       throw Exception('Error: $e');
// //     }
// //   }


// //   Future<Map<String, dynamic>> fetchCampData3(String userId) async {
// //     final String apiUrl = 'http://127.0.0.1/api_club_app/show_User_Activity3.php';
// //     try {
// //       await storage.ready;

// //       Map<String, String>? userData = storage.getItem('user_profile');
// //       String? mbId = userData?['userId'];

// //       if (mbId == null) {
// //         throw Exception('User ID not found in LocalStorage.');
// //       }

// //       var response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({'mb_id': mbId}),
// //       );

// //       if (response.statusCode == 200) {
// //         return jsonDecode(response.body);
// //       } else {
// //         throw Exception('Failed to load data from API');
// //       }
// //     } catch (e) {
// //       throw Exception('Error: $e');
// //     }
// //   }


//   @override
//   Widget build(BuildContext context) {
//     TabController _tabController = TabController(length: 1, vsync: this);
//     return Scaffold(
//       body: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //Back
//             Container(
//               child: Row(
//                 children: [
//                   Expanded(child: Container()),
//                   Container(
//                     child: IconButton(
//                       icon: Icon(Icons.arrow_back),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 5),
//             // Discover text หัวข้อ
//             Container(
//               margin: const EdgeInsets.only(left: 15),
//               child: Text(
//                 "ผลกิจกรรม",
//                 style: TextStyle(fontSize: 25),
//               ),
//             ),
//             SizedBox(height: 5),
//             // หน่วยกิตรวม
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 15),
//               width: MediaQuery.of(context).size.width,
//               height: 70,
//               decoration: BoxDecoration(
//                 color: Colors.orangeAccent,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             SizedBox(height: 5),
//             // Tabber แถบเมนู วัน สัปดาห์ เดือน
//             Container(
//               margin: const EdgeInsets.only(left: 15),
//               child: Text(
//                 "รายการเข้าร่วมกิจกรรม",
//                 style: TextStyle(fontSize: 20),
//               ),
//             ),
//             // ช่องใส่ข้อมูลแต่ละหน้า
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               height: 160,
//               width: double.infinity,
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   ListView.builder(
//                     itemCount: activityTypeData.length,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (BuildContext context, int index) {
//                       var activityType = activityTypeData[index];
//                       return Container(
//                         margin: const EdgeInsets.only(right: 15, top: 10),
//                         width: 330,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: Colors.green,
//                             width: 1.0,
//                           ),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text('Activity ID: ${activityType['act_id']}'),
//                             Text('Activity Name: ${activityType['act_name']}'),
//                             Text('Activity Year: ${activityType['act_year']}'),
//                             Text('Activity Credit: ${activityType['act_credit']}'),
//                             Text('Activity Total Max: ${activityType['act_total_max']}'),
//                           ],
//                         ),
//                       );
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //   Widget buildActivityCard(Map<String, dynamic> activity) {
// //     return FutureBuilder<Map<String, dynamic>>(
// //       future: fetchUserData(
// //           context,
// //           activity[
// //               'mb_id']), // เรียกใช้ Future fetchUserData ด้วย mb_id ของกิจกรรม
// //       builder: (context, snapshot) {
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           // หากกำลังโหลดข้อมูล จะแสดง Indicator หรืออะไรก็ตาม
// //           return CircularProgressIndicator(); // เปลี่ยนเป็น Indicator ที่คุณต้องการ
// //         } else if (snapshot.hasError) {
// //           // หากเกิดข้อผิดพลาดในการโหลดข้อมูล
// //           return Text('Error: ${snapshot.error}');
// //         } else {
// //           // หากโหลดข้อมูลเสร็จสมบูรณ์ จะสร้าง Card โดยใช้ข้อมูลที่ได้จาก Future fetchUserData
// //           Map<String, dynamic> userData =
// //               snapshot.data ?? {}; // ดึงข้อมูลที่ได้จาก Future
// //           return Card(
// //             color: Colors.white,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(15),
// //               side: BorderSide(color: Colors.green, width: 1),
// //             ),
// //             child: ListTile(
// //               leading: Image.asset(
// //                 'assate/images/act_03.png',
// //                 fit: BoxFit.cover,
// //                 width: 100,
// //                 height: 170,
// //               ),
// //               title: Text(
// //                 activity['act_name'] ?? '',
// //                 style: TextStyle(
// //                   color: Colors.red,
// //                   fontSize: 10,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               subtitle: Text(
// //                 'Location: ${activity['act_location'] ?? ''}\n'
// //                 'Date: ${activity['date_start'] ?? ''} - ${activity['date_end'] ?? ''}\n'
// //                 'Registrations: ${activity['act_current_registrations'] ?? ''}\n'
// //                 'User Name: ${userData['membername'] ?? ''}\n' // แสดงชื่อผู้ใช้จากข้อมูลที่ได้จาก Future
// //                 'User Email: ${userData['memberEmail'] ?? ''}\n' // แสดงอีเมลผู้ใช้จากข้อมูลที่ได้จาก Future
// //                 'User Tel: ${userData['memberTel'] ?? ''}', // แสดงเบอร์โทรศัพท์ผู้ใช้จากข้อมูลที่ได้จาก Future
// //                 style: TextStyle(
// //                   color: Colors.blue,
// //                   fontSize: 14,
// //                 ),
// //               ),
// //               trailing: ElevatedButton(
// //                 onPressed: () {
// //                   // ระบุการดำเนินการเมื่อปุ่มถูกกด
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   primary: Colors.black,
// //                 ),
// //                 child: Text(
// //                   'ลงทะเบียน',
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         }
// //       },
// //     );
// //   }
// // }
