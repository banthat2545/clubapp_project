// import 'package:clubapp_project/pages/login_screen.dart';
import 'package:clubapp_project/widget/app_text.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

List<String> activities = ['กิจกรรม 1', 'กิจกรรม 2', 'กิจกรรม 3'];

class _Home_ScreenState extends State<Home_Screen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  get child => null;

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),

            //discover text หัวข้อ
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: AppText(
                text: "หน้าแรก",
                size: 25,
              ),
            ),

            SizedBox(
              height: 5,
            ),

            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // จัดตำแหน่งปุ่มที่ด้านขวา
                children: [
                  Material(
                    color: const Color.fromARGB(255, 199, 199, 199),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Text(
                          "ตรวจสอบรายชื่อเข้าร่วมกิจกรรม",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "Maehongson",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Material(
                    color: const Color.fromARGB(255, 199, 199, 199),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Text(
                          "ลงทะเบียน",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: "Maehongson",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Material(
                    color: const Color.fromARGB(255, 199, 199, 199),
                    borderRadius: BorderRadius.circular(30),
                    child: InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: Text(
                          "กิจกรรม",
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



            Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      elevation: 4, // ความโค้งมนของ Card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // ปรับรูปร่างของ Card
                        side: BorderSide(
                          color: Color(0xFF0088FF), // เปลี่ยนสีขอบของ Card เป็นสีน้ำเงิน
                          width: 2, // ความหนาของเส้นขอบ
                        ),
                      ),
                      child: Container(
                        height: 150, // ส่วนสูงของ Card
                        decoration: BoxDecoration(
                          color: Color(0xFF0088FF), // เปลี่ยนสีขอบของ Card เป็นสีน้ำเงิน
                          borderRadius: BorderRadius.circular(10), // ปรับรูปร่างของ Card
                        ),
                        child: Center(
                          child: Text('Card 1', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5), // ระยะห่างระหว่าง Card
                  Expanded(
                    child: Card(
                      elevation: 4, // ความโค้งมนของ Card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // ปรับรูปร่างของ Card
                        side: BorderSide(
                          color: Color.fromRGBO(74, 252, 38, 100), // เปลี่ยนสีขอบของ Card เป็นสีน้ำเงิน
                          width: 2, // ความหนาของเส้นขอบ
                        ),
                      ),
                      child: Container(
                        height: 150, // ส่วนสูงของ Card
                        decoration: BoxDecoration(
                          color:Color(0xFF4AFC26),
 // เปลี่ยนสีขอบของ Card เป็นสีน้ำเงิน
                          borderRadius: BorderRadius.circular(10), // ปรับรูปร่างของ Card
                        ),
                        child: Center(
                          child: Text('Card 2', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ),
                ],
              )

            ),




           
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: AppText(
                text: "รายการกิจกรรม",
                size: 20,
                color: Colors.black,
              ),
            ),


            // Container(
            //   margin: const EdgeInsets.only(right: 15, left: 15),
            //   height: 30,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: const Color.fromARGB(255, 45, 212, 51),
            //       width: 1.0,
            //     ),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              height: 350,
              child: ListView.builder(
                itemCount: activities.length, // จำนวน rows
                itemBuilder: (BuildContext context, int rowIndex) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.orange, // สามารถเปลี่ยนสีตามต้องการ
                    ),
                    child: Center(
                      child: Text(
                        activities[rowIndex],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
// class CircleTabIndicator extends Decoration {
//   final Color color;
//   double radius;
//   CircleTabIndicator({required this.color, required this.radius});
//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//     // TODO: implement createBoxPainter
//     return _CirclePainter(color: color, radius: radius);
//   }
// }

// class _CirclePainter extends BoxPainter {
//   final Color color;
//   double radius;
//   _CirclePainter({required this.color, required this.radius});
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     Paint _paint = Paint();
//     _paint.color = color;
//     _paint.isAntiAlias = true;
//     final Offset circleOffset = Offset(
//         configuration.size!.width / 2 - radius / 2,
//         configuration.size!.height - radius);
//     canvas.drawCircle(offset + circleOffset, radius, _paint);
//   }
// }
