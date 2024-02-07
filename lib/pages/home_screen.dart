import 'package:clubapp_project/pages/LoginScreen.dart';
import 'package:clubapp_project/widget/app_text.dart';
import 'package:flutter/material.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}
List<String> activities = ['กิจกรรม 1', 'กิจกรรม 2', 'กิจกรรม 3'];
class _Home_ScreenState extends State<Home_Screen> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  get child => null;

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Back
            // Container(
            //   child: Row(
            //     children: [
            //       // Icon(Icons.menu, size: 30, color: Colors.black54),
            //       Expanded(child: Container()),
            //       Container(
            //         child: BackButtonWidget(),
            //       ),
            //     ],
            //   ),
            // ),

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

            //ค้นหา
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black26),
                        labelText: 'ค้นหา',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 60, // กำหนดความกว้าง
                    height: 45, // กำหนดความยาว
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF3AE374), // กำหนดพื้นหลัง
                      ),
                      onPressed: () {
                        String searchTerm = searchController.text;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginScreen()));
                        print('ค้นหาข้อมูล: $searchTerm');
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize
                            .min, // ทำให้ Column มีความกว้างเท่ากับปุ่ม
                        mainAxisAlignment: MainAxisAlignment
                            .center, // จัดให้เล็กเล่นอยู่ตรงกลาง
                        children: [
                          Icon(Icons.search, color: Colors.white, size: 30),
                          //Text('ค้นหา'),
                        ],
                      ),
                    ),
                  ),
                ],
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

            SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'รายการ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 220),
                      Text(
                        'ทั้งหมด',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ยอดบริจาค',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 170),
                      Text(
                        '6000',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              ),
            ),

            //tabber แถบเมนู วัน สัปดาห์ เดือน
            Container(
                child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                // indicatorSize: TabBarIndicatorSize.label,
                // indicator: CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                tabs: const [
                  Tab(
                    child: Text(
                      "วัน",
                      style: TextStyle(
                        fontFamily: 'Maehongson', // ระบุฟอนต์ที่คุณต้องการใช้
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "สัปดาห์",
                      style: TextStyle(
                        fontFamily: 'Maehongson', // ระบุฟอนต์ที่คุณต้องการใช้
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "เดือน",
                      style: TextStyle(
                        fontFamily: 'Maehongson', // ระบุฟอนต์ที่คุณต้องการใช้
                      ),
                    ),
                  ),
                ],
              ),
            )),

            //ช่องใส่ข้อมูลแต่ละหน้า
            Container(
              padding: const EdgeInsets.only(left: 15),
              height: 160,
              width: double.maxFinite,
              child: TabBarView(
                controller: _tabController,
                children: [
                  //วัน
                  ListView.builder(
                    itemCount: 7,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 15, top: 10),
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'ยอดบริจาค',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '4599',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '18/10/23',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'ตลาดหนองใหญ่',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  //สัปดาห์
                  ListView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          width: 330,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 231, 162, 71),
                          ),
                        );
                      }),
                  //เดือน
                  ListView.builder(
                      itemCount: 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 15, top: 10),
                          width: 330,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                        );
                      }),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Container(
              margin: const EdgeInsets.only(left: 15),
              child: AppText(
                text: "รายการกิจกรรม",
                size: 20,
                color: Colors.black,
              ),
            ),

            Container(
              margin: const EdgeInsets.only(right: 15, left: 15),
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 45, 212, 51),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
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
