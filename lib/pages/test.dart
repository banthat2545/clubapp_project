// Card(
//       margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       color: Color.fromRGBO(255, 255, 255, 1),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//         side: BorderSide(color: Colors.green, width: 1.5),
//       ),
//       child: Row(children: [
//         // Column 1: Image
//         Expanded(
//           flex: 1,
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(10), // ปรับความโค้งของขอบรูป
//               child: Image.asset(
//                 'assate/images/act_03.png',
//                 fit: BoxFit.cover,
//                 width: 150,
//                 height: 150,
//               ),
//             ),
//           ),
//         ),

//         Expanded(
//           flex: 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Row แรก: ข้อความทั้งหมด
//               Row(
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           activity['act_name'] ?? '',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             height: 2, // ตั้งค่าระยะห่างระหว่างบรรทัด
//                           ),
//                         ),
//                         SizedBox(
//                             height:
//                                 1), // ปรับระยะห่างระหว่างบรรทัดเป็น 4 พิกเซล
//                         Text(
//                           'Location: ${activity['act_location'] ?? ''}\n',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 13,
//                             height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
//                           ),
//                         ),
//                         Text(
//                           'Date: ${activity['date_start'] ?? ''} - ${activity['date_end'] ?? ''}\n',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 13,
//                             height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
//                           ),
//                         ),
//                         Text(
//                           'Registrations: ${activity['act_current_registrations'] ?? ''}',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 13,
//                             // height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
//                           ),
//                         ),
//                         Text(
//                           'Registrations: ${activity['start_datetime'] ?? ''}',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 13,
//                             // height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
//                           ),
//                         ),
//                         Text(
//                           'Registrations: ${activity['end_datetime'] ?? ''}',
//                           style: TextStyle(
//                             color: Colors.green,
//                             fontSize: 13,
//                             // height: 0.8, // ตั้งค่าระยะห่างระหว่างบรรทัด
//                           ),
//                         ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 5), // ปรับระยะห่างระหว่าง Row แรกและ Row ที่สอง
//             ],
//           ),
//         ),
//       ]),
//     );