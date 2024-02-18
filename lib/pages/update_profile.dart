import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:clubapp_project/widget/back_button.dart';
import 'package:flutter/material.dart';

class Update_Profile extends StatefulWidget {
  final String mbId;

  const Update_Profile({Key? key, required this.mbId}) : super(key: key);

  @override
  State<Update_Profile> createState() => _Update_ProfileState();
}

class _Update_ProfileState extends State<Update_Profile> {
  final formKey = GlobalKey<FormState>();
  late Future<dynamic> useredit;

  String selectedValueFaculty = '';
  void initState() {
    super.initState();
    useredit = usereditProfile(widget.mbId);
  }

  Future<dynamic> usereditProfile(String mbId) async {
    final apiUrl = 'http://127.0.0.182/api_club_app/Update_Profile.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mb_id': mbId,
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
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assate/images/01_PF.jpg"),
                  fit: BoxFit.cover)),
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
                                      FutureBuilder<dynamic>(
                                        future:
                                            useredit, // ใช้ usereditProfile()() เพื่อเรียกฟังก์ชันหรือโปรเซสที่คืน Future<dynamic>
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'),
                                            );
                                          } else {
                                            List<dynamic> useredits = snapshot
                                                    .data[
                                                'response']; // แก้ชื่อตัวแปร UpdateMenbers เป็น useredits

                                            return SingleChildScrollView(
                                              child: Column(
                                                children: useredits.map(
                                                  (useredit) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  "Maehongson",
                                                            ),
                                                            controller:
                                                                TextEditingController(
                                                                    text:
                                                                        'mb_id: ${useredit['mb_id']}'),
                                                            // ใช้ TextEditingController และกำหนดค่าเริ่มต้นด้วย text
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'รหัสนักศึกษา',
                                                              labelStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    "Maehongson",
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 3.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 2.0),
                                                              ),
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black26,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    "Maehongson",
                                                              ),
                                                              hintText:
                                                                  "รหัสนักศึกษา",
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              prefixIcon: Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .black26,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .symmetric(
                                                                vertical: 5.0,
                                                                horizontal: 5.0,
                                                              ),
                                                            ),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'กรุณากรอกข้อมูล';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: TextFormField(
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontFamily:
                                                                  "Maehongson",
                                                            ),
                                                            controller:
                                                                TextEditingController(
                                                                    text:
                                                                        'mb_name:${useredit['mb_name']}'), // ใช้ TextEditingController และกำหนดค่าเริ่มต้นด้วย text
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'ชื่อ-สกุล',
                                                              labelStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black38,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    "Maehongson",
                                                              ),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 3.0),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 2.0),
                                                              ),
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black26,
                                                                fontSize: 15,
                                                                fontFamily:
                                                                    "Maehongson",
                                                              ),
                                                              hintText:
                                                                  "รหัสนักศึกษา",
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              prefixIcon: Icon(
                                                                Icons.person,
                                                                color: Colors
                                                                    .black26,
                                                              ),
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .symmetric(
                                                                vertical: 5.0,
                                                                horizontal: 5.0,
                                                              ),
                                                            ),
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'กรุณากรอกข้อมูล';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ), // Spacing between each row of data
                                                      ],
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            );
                                          }
                                        },
                                      )

                                      
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
