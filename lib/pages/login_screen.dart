import 'dart:convert';
import 'package:clubapp_project/pages/register_screen.dart';
import 'package:clubapp_project/widget/back_button.dart';
import 'package:clubapp_project/widget/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import 'dart:async';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  var formKey = GlobalKey<FormState>();
  var idController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  Future<void> signin() async {
  String mb_email = idController.text;
  String mb_password = passwordController.text;

  if (mb_email.isEmpty || mb_password.isEmpty) {
    return;
  }

  var url = Uri.parse('http://192.168.1.200/api_club_app/login.php');
  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'mb_email': mb_email, 'mb_password': mb_password}),
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    String message = data['message'];
    String? mb_id = data['mb_id'];
    print(mb_id);
    if (message == 'ล็อกอินสำเร็จ') {

      Provider.of<User_Provider>(context,listen: false).setUserId(mb_id!);
      Navigator.pushReplacementNamed(context, '/OptionsScreen');
    } else {

    }
  } else {

  }
}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage("images/01_PF.jpg"), fit: BoxFit.cover)),
        // ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(
            builder: (context, cons) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: cons.maxHeight,
                ),
                child: SingleChildScrollView(
                  child: Form(
                    // key: formKey,
                    child: Column(
                      children: [
                        BackButtonWidget(),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 210, 0, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(60),
                              ),
                            ),
                            child: Form(
                              //key: formKey,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 8),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    // children: [
                                    //   Form(
                                    //     key: formKey,
                                    //     child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "เข้าสู่ระบบ",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                              fontFamily: "Maehongson"),
                                        ),
                                      ),
                                      //กรอกรหัสนักศึกษา
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
                                          controller: idController,
                                          // controller: one_value,    //รับค่า ไปเก็ยไว้ในตัวเเปล two_value
                                          decoration: InputDecoration(
                                            labelText: 'ชื่อผู้ใช้',
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
                                            hintText: "อีเมลมหาวิทยาลัย",
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
                                                    horizontal: 5.0),
                                          ),
                                        ),
                                      ),

                                      //กรอกรหัสผ่าน
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
                                              }
                                              return null;
                                            },
                                            controller: passwordController,
                                            obscureText: isObsecure
                                                .value, // ใช้ isObsecure ใน obscureText
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

                                      //ปุ่มเข้าสู่ระบบ
                                      //  Padding(
                                      //    padding: const EdgeInsets.all(5.0),
                                      //   child: Material(
                                      //     color: Colors.green, // สีพื้นหลังของปุ่ม
                                      //     borderRadius: BorderRadius.circular(30), // ความโค้งขอบ
                                      //     child: InkWell(
                                      //       onTap: () {
                                      //         // รหัสที่คุณต้องการให้ทำเมื่อปุ่มถูกคลิก
                                      //          bool pass = formKey.currentState!.validate();
                                      //           if (pass) {
                                      //         //get_login(); // Corrected: Call _onClick() function
                                      //       }
                                      //       },
                                      //       borderRadius: BorderRadius.circular(30),
                                      //       child: Padding(
                                      //         padding: EdgeInsets.symmetric(
                                      //           vertical: 10,
                                      //           horizontal: 113,
                                      //         ),
                                      //         child: Text(
                                      //           " เข้าสู่ระบบ ",
                                      //           style: TextStyle(
                                      //             color: Colors.white, // สีข้อความ
                                      //             fontSize: 15,
                                      //             fontFamily: "Maehongson",
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      //  ),

                                      // Login Button
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Material(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: InkWell(
                                            onTap: () {
                                              bool pass = formKey.currentState!
                                                  .validate();
                                              if (pass) {
                                                signin();
                                              }
                                            },
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 113,
                                              ),
                                              child: Text(
                                                " เข้าสู่ระบบ ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontFamily: "Maehongson",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      //คำอธิบาย
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "ยินดีต้อนรับสมาชิกชมรมอนุรักษ์ธรรมชาติเเละสิ่งเเวดล้อม",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black,
                                              fontFamily: "Maehongson"),
                                        ),
                                      ),

                                      //
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Material(
                                          color:
                                              Colors.black, // สีพื้นหลังของปุ่ม
                                          borderRadius: BorderRadius.circular(
                                              30), // ความโค้งขอบ
                                          child: InkWell(
                                            onTap: () {
                                              // รหัสที่คุณต้องการให้ทำเมื่อปุ่มถูกคลิก

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterScreen(),
                                                ),
                                              );
                                            },
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10,
                                                horizontal: 113,
                                              ),
                                              child: Text(
                                                "สมัครสมาชิก",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:
                                                      Colors.white, // สีข้อความ
                                                  fontSize: 14,
                                                  fontFamily: "Maehongson",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      //email
                                      //textTitle(),
                                      //emailInput(),
                                      //passwordInput(),
                                      //signInButton(),
                                      //TextDetails(),
                                      //signUpButton(),
                                    ],
                                    //),
                                    //),
                                    //],
                                  ),
                                ),
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
      ],
    );
  }
}
