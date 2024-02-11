import 'package:clubapp_project/pages/login_screen.dart';
import 'package:clubapp_project/widget/app_text.dart';
import 'package:clubapp_project/widget/app_large_text.dart';
import 'package:flutter/material.dart';

class first_screen extends StatefulWidget {
  const first_screen({super.key});

  @override
  State<first_screen> createState() => _first_screenState();
}

class _first_screenState extends State<first_screen> {
  List images = [
    // "01_welcome.jpg",
    // // "02_welcome.jpg",
    "03_welcome.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assate/images/" + images[index]),
                      fit: BoxFit.cover)),
              child: Container(
                margin: const EdgeInsets.only(top: 100, left: 20, right: 20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: "Welcome"),
                        // AppLargeText(text: "Prem",color: Colors.pink,),
                        AppText(text: "ชมรมอนุรักษ์ธรรมชาติเเละสิ่งเเลดล้อม"),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 200,
                          child: AppText(
                            text:
                                "ชมรมอนุรักษ์ธรรมชาติเเละสิ่งเเลดล้อม ชมรมอนุรักษ์ธรรมชาติเเละสิ่งเเลดล้อม ชมรมอนุรักษ์ธรรมชาติเเละสิ่งเเลดล้อม",
                            size: 12,
                            // color: AppColors.textColor2
                          ),
                        ),
                        responsiveButton(),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget responsiveButton() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Login_Screen(),
            ),
          );
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 15,
          ),
          child: const Text(
            "ยินดีต้อนรับ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          elevation: 20,
          // primary: Color.fromARGB(255, 0, 81, 255),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
