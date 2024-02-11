import 'dart:convert';
// import 'dart:io';
// import 'package:clubapp1/pages/dropdown_madel_branch.dart';
// import 'package:clubapp1/pages/dropdown_model.dart';
// import 'package:clubapp1/pages/login_screen.dart';
import 'package:clubapp_project/pages/login_screen.dart';
import 'package:clubapp_project/widget/back_button.dart';
// import 'package:clubapp1/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
//import 'package:fluttertoast/fluttertoast.dart';
// import 'package:clubapp1/widget/back_button.dart';
// import 'dart:async';
// import 'package:dropdown_model_list/dropdown_model_list.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController password = TextEditingController();

  String selectedValueFaculty = '';

  



  // Future<List<DropdownModal>> get getPost async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('http://172.24.136.100:80/club_app/get_faculties.php'));
     
  //     if (response.statusCode == 200) {
  //       final body = json.decode(response.body) as List;
  //       return body.map((e) {
  //         final map = e as Map<String, dynamic>;
  //         return DropdownModal(
  //           faculty_id: map['faculty_id'],
  //           faculty_name: map['faculty_name'],
  //         );
  //       }).toList();
  //     }
  //   } on SocketException {
  //     throw Exception('ไม่มีอินเทอร์เน็ต');
  //   }
  //   throw Exception('เกิดข้อผิดพลาดในการดึงข้อมูล');
  // }

  // Future<List<DropdownModalBranch>> get getPostBranch async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('http://172.24.136.100:80/club_app/get_branches.php'));
  //     final body = json.decode(response.body) as List;

  //     if (response.statusCode == 200) {
  //       return body.map((e) {
  //         final map = e as Map<String, dynamic>;
  //         return DropdownModalBranch(
  //           branch_id: map['branch_id'],
  //           branch_name: map['branch_name'],
  //         );
  //       }).toList();
  //     }
  //   } on SocketException {    
  //     throw Exception('ไม่มีอินเทอร์เน็ต');
  //   }
  //   throw Exception('เกิดข้อผิดพลาดในการดึงข้อมูล');
  // }



//   Future<List<DropdownModal>> getPost(String selectedValueFaculty) async {
//   try {
//     final response = await http.get(Uri.parse('http://10.50.50.208:80/club_app/get_faculties.php'));
//     final body = json.decode(response.body) as Map<String, dynamic>;

//     if (response.statusCode == 200 && body['status'] == true) {
//       final List<dynamic> faculties = body['faculties'];

//       return faculties.map((e) {
//         final map = e as Map<String, dynamic>;
//         return DropdownModal(
//           faculty_id: map['faculty_id'],
//           faculty_name: map['faculty_name'],
//         );
//       }).toList();
//     }
//     throw Exception('Error fetching faculties');
//   } on SocketException {
//     throw Exception('No internet connection');
//   } catch (error) {
//     throw Exception('Error fetching faculties: $error');
//   }
// }

//   Future<List<DropdownModalBranch>> fetchBranches(String facultyId) async {
//   try {
//     final response = await http.get(Uri.parse('http://10.50.50.208:80/club_app/get_branches.php?faculty_id=$facultyId'));
//     final body = json.decode(response.body);

//     if (response.statusCode == 200 && body['status'] == true) {
//       final List<dynamic> branches = body['branches'];

//       return branches.map((e) {
//         final map = e as Map<String, dynamic>;
//         return DropdownModalBranch(
//           branch_id: map['branch_id'],
//           branch_name: map['branch_name'],
//         );
//       }).toList();
//     }
//     throw Exception('Error fetching branches');
//   } on SocketException {
//     throw Exception('No internet connection');
//   } catch (error) {
//     throw Exception('Error fetching branches: $error');
//   }
// }


//   Future<List<DropdownModalBranch>> getPostBranch(String facultyId) async {
//   try {
//     final response = await http.get(
//         Uri.parse('http://10.50.50.208:80/club_app/get_branches.php?faculty_id=$facultyId'));
//     final body = json.decode(response.body) as Map<String, dynamic>;

//     if (response.statusCode == 200 && body['status'] == true) {
//       final List<dynamic> branches = body['branches'];

//       return branches.map((e) {
//         final map = e as Map<String, dynamic>;
//         return DropdownModalBranch(
//           branch_id: map['branch_id'],
//           branch_name: map['branch_name'],
//         );
//       }).toList();
//     }
//   } on SocketException {
//     throw Exception('ไม่มีอินเทอร์เน็ต');
//   }
//   throw Exception('เกิดข้อผิดพลาดในการดึงข้อมูลสาขา');
// }

  

  void _onClick() {
    http
        .post(Uri.parse('http://172.24.142.139:80/club_app/signup.php'),
            body: jsonEncode({
              'mb_id': id.text,
              'mb_name': name.text,
              'mb_email': email.text,
              'mb_tel': tel.text,
              'mb_password': password.text,
            }))
        .then((res) {
      print('Response Status Code: ${res.statusCode}');
      // Check the response from the server
      if (res.statusCode == 200) {
        //if (res.statusCode >= 200 && res.statusCode < 300) {
        // การลงทะเบียนสำเร็จ
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('สมัครสมาชิกสำเร็จ'),
              content:
                  Text('ยินดีต้อนรับสมาชิกชมรมนุรักษ์ธรรมชาติและสิ่งแวดล้อม.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login_Screen(),
                      ),
                    ); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (res.statusCode == 400) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('สมัครสมาชิกไม่สำเร็จ'),
              content: Text('กรุณาลองใหม่อีกครั้ง เนื่องจากรหัสนี้มีอยู่แล้ว.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (res.statusCode == 404) {
        // Not Found
        // Show an error message indicating that the resource was not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('สมัครสมาชิกไม่สำเร็จ'),
              content: Text('กรุณาลองใหม่อีกครั้ง เนื่องจากรหัสนี้มีอยู่แล้ว.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (res.statusCode == 500) {
        // Internal Server Error
        // Show an error message indicating a server-side issue
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('สมัครสมาชิกไม่สำเร็จ'),
              content: Text('กรุณาลองใหม่อีกครั้ง เนื่องจากรหัสนี้มีอยู่แล้ว.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // การลงทะเบียนล้มเหลว แสดงข้อความแสดงข้อผิดพลาด
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('สมัครสมาชิกไม่สำเร็จ'),
              content: Text('กรุณาลองใหม่อีกครั้ง เนื่องจากรหัสนี้มีอยู่แล้ว.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterScreen(),
                      ),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  var isObsecure = true.obs;

 

  var dropdownvalue;

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/01_PF.jpg"), fit: BoxFit.cover)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Form(
              // key: formKey,
              child: LayoutBuilder(
                builder: (context, cons) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: cons.maxHeight,
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            BackButtonWidget(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(60),
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 8),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "สมัครสมาชิก",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                              fontFamily: "Maehongson"),
                                        ),
                                      ),
                                      //รหัสนักศึกษา
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: TextFormField(
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontFamily: "Maehongson",
                                          ),
                                          controller: id,
                                          decoration: InputDecoration(
                                            labelText: 'รหัสนักศึกษา',
                                            labelStyle: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 15,
                                              fontFamily: "Maehongson",
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 3.0),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.green,
                                                  width: 2.0),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.black26,
                                              fontSize: 15,
                                              fontFamily: "Maehongson",
                                            ),
                                            hintText: "รหัสนักศึกษา",
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: Colors.black26,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 5.0,
                                                    horizontal: 5.0),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'กรุณากรอกข้อมูล';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      //ขื่อ-สกุล

                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: TextFormField(
                                          style: TextStyle(
                                            // fontSize: 15,
                                            color: Colors.green,
                                            fontFamily: "Maehongson",
                                          ),
                                          controller:
                                              name, //รับค่า ไปเก็ยไว้ในตัวเเปล nameController
                                          decoration: InputDecoration(
                                              labelText: 'ชื่อ-สกุล',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 2.0),
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              hintText: "ชื่อ-สกุล",
                                              //hintStyle: TextStyle(fontWeight: FontWeight.w600)
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: Colors.black26,
                                              ),
                                              // contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0)),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'กรุณากรอกข้อมูล';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      //อีเมล
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: TextFormField(
                                          style: TextStyle(
                                            // fontSize: 15,
                                            color: Colors.green,
                                            fontFamily: "Maehongson",
                                          ),
                                          //onTap: validateMemberEmail(), //เเทรกฟังก์ชัน
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'กรุณากรอกข้อมูล';
                                            }
                                            return null;
                                          },
                                          controller:
                                              email, //รับค่า ไปเก็ยไว้ในตัวเเปล emailController
                                          decoration: InputDecoration(
                                              labelText: 'อีเมล',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 2.0),
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              hintText: "อีเมลของท่าน",
                                              //hintStyle: TextStyle(fontWeight: FontWeight.w600)
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: Icon(
                                                Icons.email,
                                                color: Colors.black26,
                                              ),
                                              // contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0)),
                                        ),
                                      ),
                                      //เบอร์โทรศัพท์
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: TextFormField(
                                          style: TextStyle(
                                            // fontSize: 15,
                                            color: Colors.green,
                                            fontFamily: "Maehongson",
                                          ),
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return 'กรุณากรอกข้อมูล';
                                            }
                                            return null;
                                          },
                                          controller:
                                              tel, //รับค่า ไปเก็ยไว้ในตัวเเปล telController
                                          decoration: InputDecoration(
                                              labelText: 'เบอร์โทรศัพท์',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 3.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: Colors.green,
                                                    width: 2.0),
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.black26,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              hintText: "เบอร์โทรศัพท์ของท่าน",
                                              //hintStyle: TextStyle(fontWeight: FontWeight.w600)
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: Icon(
                                                Icons.add_call,
                                                color: Colors.black26,
                                              ),
                                              // contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0)
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0)),
                                        ),
                                      ),

                                      

                                      
//   Padding(
//   padding: const EdgeInsets.all(5.0),
//   child: FutureBuilder<List<DropdownModal>>(
//     future: getPost(selectedValueFaculty), 
//     builder: (context, facultySnapshot) {
//       if (facultySnapshot.hasData) {
//         return Column(
//           children: [
//             DropdownButtonFormField<String>(
//               hint: Text('เลือกคณะ'),
//               isExpanded: true,
//               value: selectedValueFaculty,
//               icon: Icon(Icons.add_circle_outline),
//               items: facultySnapshot.data!.map((e) {
//                 return DropdownMenuItem<String>(
//                   value: e.faculty_name.toString(),
//                   child: Text(e.faculty_name.toString()),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedValueFaculty = value!;
//                 });

//                 // Update the branches FutureBuilder with the new faculty value
//               },
//             ),
//             // FutureBuilder for the branch dropdown
//             FutureBuilder<List<DropdownModalBranch>>(
//               future: fetchBranches(selectedValueFaculty),
//               builder: (context, branchSnapshot) {
//                 if (branchSnapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (branchSnapshot.hasError) {
//                   return Text('Error: ${branchSnapshot.error}');
//                 } else if (branchSnapshot.hasData) {
//                   return DropdownButtonFormField<String>(
//                     hint: Text('เลือกสาขา'),
//                     isExpanded: true,
//                     value: selectedValueBranch,
//                     icon: Icon(Icons.add_circle_outline),
//                     items: branchSnapshot.data!.map((e) {
//                       return DropdownMenuItem<String>(
//                         value: e.branch_name.toString(),
//                         child: Text(e.branch_name.toString()),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedValueBranch = value!;
//                       });
//                     },
//                   );
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               },
//             ),
//           ],
//         );
//       } else if (facultySnapshot.hasError) {
//         return Text('Error: ${facultySnapshot.error}');
//       } else {
//         return CircularProgressIndicator();
//       }
//     },
//   ),
// ),


//                                       Padding(
//                                         padding: const EdgeInsets.all(5.0),
//                                         child: FutureBuilder<List<DropdownModalBranch>>(
//                                           future: getPostBranch(selectedValueFaculty), // Call the function with the selected faculty value
//                                           builder: (context, snapshot) {
//                                             if (snapshot.hasData) {
//                                               return DropdownButtonFormField<String>(
//                                                 hint: Text('เลือกสาขา'),
//                                                 isExpanded: true,
//                                                 value: selectedValueBranch,
//                                                 icon: Icon(Icons.add_circle_outline),
//                                                 items: snapshot.data!.map((e) {
//                                                   return DropdownMenuItem<String>(
//                                                     value: e.branch_name.toString(),
//                                                     child: Text(e.branch_name.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     selectedValueBranch = value!;
//                                                   });
//                                                 },
//                                               );
//                                             } else if (snapshot.hasError) {
//                                               return Text('Error: ${snapshot.error}');
//                                             } else {
//                                               return CircularProgressIndicator();
//                                             }
//                                           },
//                                         ),
//                                       ),


                                      //รหัสผ่าน
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Obx(
                                          () => TextFormField(
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: "Maehongson",
                                            ),
                                            obscureText: isObsecure
                                                .value, // ใช้ isObsecure ใน obscureText
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return 'กรุณากรอกข้อมูล';
                                              }
                                              return null;
                                            },
                                            controller:
                                                password, //รับค่า ไปเก็ยไว้ในตัวเเปล passwordController
                                            decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  isObsecure.value =
                                                      !isObsecure.value;
                                                },
                                                child: Icon(
                                                  isObsecure.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors
                                                      .green, // เปลี่ยนสีของ icon
                                                ),
                                              ),
                                              labelText: 'รหัสผ่าน',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 2.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 2.0),
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              hintText: "รหัสผ่าน",
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: Icon(
                                                Icons.key,
                                                color: Colors.black26,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //ยืนยันรหัสผ่าน
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Obx(
                                          () => TextFormField(
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: "Maehongson",
                                            ),
                                            validator: (val) {
                                              if (val!.isEmpty) {
                                                return 'กรุณากรอกข้อมูล';
                                              } else if (val != password.text) {
                                                return 'รหัสผ่านไม่ถูกต้อง';
                                              }
                                              return null;
                                            },
                                            obscureText: isObsecure
                                                .value, // ใช้ isObsecure ใน obscureText
                                            // controller: mb_applyPassword,
                                            decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                onTap: () {
                                                  isObsecure.value =
                                                      !isObsecure.value;
                                                },
                                                child: Icon(
                                                  isObsecure.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors
                                                      .green, // เปลี่ยนสีของ icon
                                                ),
                                              ),
                                              labelText: 'ยืนยันรหัสผ่าน',
                                              labelStyle: TextStyle(
                                                  color: Colors.black38,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 2.0),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.green,
                                                    width: 2.0),
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson"),
                                              hintText: "ยืนยันรหัสผ่าน",
                                              filled: true,
                                              fillColor: Colors.white,
                                              prefixIcon: Icon(
                                                Icons.key,
                                                color: Colors.black26,
                                              ),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 0, 10, 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //คำอธิบาย
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "ยินดีต้อนรับสมาชิกชมรมอนุรักษ์ธรรมชาติเเละสิ่งเเวดล้อม",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                              fontFamily: "Maehongson"),
                                        ),
                                      ),
                                      //ปุ่มสมัคร
                                      Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            bool pass = formKey.currentState!
                                                .validate();
                                            if (pass) {
                                              _onClick(); // Corrected: Call _onClick() function
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors
                                                .blue, // Set your desired color here
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal:
                                                  20, // Adjust the horizontal padding as needed
                                            ),
                                            child: Text(
                                              "สมัครสมาชิก",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color:
                                                    Colors.white, // Text color
                                                fontSize:
                                                    14, // Adjust the font size as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

var selectedValueBranch;
var selectedValue;
