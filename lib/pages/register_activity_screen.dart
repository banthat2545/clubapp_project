// import 'dart:async';
import 'package:clubapp_project/widget/app_text.dart';
import 'package:clubapp_project/widget/back_button.dart';
import 'package:flutter/material.dart';
// import 'package:clubapp_project/pages/activity_controller.dart';
// import 'package:clubapp_project/pages/activity_model.dart';

class Register_ToJoin_Screen extends StatefulWidget {
  const Register_ToJoin_Screen({Key? key}) : super(key: key);

  @override
  State<Register_ToJoin_Screen> createState() => _Register_ToJoin_ScreenState();
}

class _Register_ToJoin_ScreenState extends State<Register_ToJoin_Screen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  // List<activityModel> activityList = [];
  // StreamController _streamController = StreamController();

  // Future getAllActivity() async {
  //   activityList = await activitycontroller().getactivity();
  //   _streamController.sink.add(activityList);
  // }

  // @override
  // void initState() {
  //   Timer.periodic(Duration(seconds: 1), (timer) {
  //     getAllActivity();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
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
                text: "ลงทะเบียนเข้าร่วมกิจกรรม",
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
                  ListView.builder(
                      itemCount: 1,
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
                        );
                      }),
                  ListView.builder(
                      itemCount: 7,
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
              // child: StreamBuilder(
              //   stream: _streamController.stream,
              //   builder: (context, snapshost) {
              //     if (snapshost.hasData) {
              //       return ListView.builder(itemBuilder: ((context, index) {
              //         activityModel activity = activityList[index];
              //         return ListTile(
              //           title: Text(activity.act_location),
              //         );
              //       }));
              //     }
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   },
              // )
            // )
          ],
        ),
      ),
    );
  }
}
