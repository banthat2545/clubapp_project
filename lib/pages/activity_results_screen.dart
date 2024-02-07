import 'package:clubapp_project/widget/app_text.dart';
import 'package:clubapp_project/widget/back_button.dart';
import 'package:flutter/material.dart';

class Activity_Results_Screen extends StatefulWidget {
  const Activity_Results_Screen({Key? key}) : super(key: key);

  @override
  State<Activity_Results_Screen> createState() => _Activity_Results_ScreenState();
}

class _Activity_Results_ScreenState extends State<Activity_Results_Screen> with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

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
              child: AppText(text: "ผลกิจกรรม", size: 25,),
            ),

            SizedBox(height: 5,),

            //ค้นหา
            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search, color: Colors.black26),
                        labelText: 'ค้นหา',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: 5,),

                  SizedBox(
                    width: 60, // กำหนดความกว้าง
                    height: 45,  // กำหนดความยาว
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF3AE374), // กำหนดพื้นหลัง
                      ),
                      onPressed: () {
                        String searchTerm = searchController.text;
                        print('ค้นหาข้อมูล: $searchTerm');
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize.min, // ทำให้ Column มีความกว้างเท่ากับปุ่ม
                        mainAxisAlignment: MainAxisAlignment.center, // จัดให้เล็กเล่นอยู่ตรงกลาง
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

            SizedBox(height: 5,),

            Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // จัดตำแหน่งปุ่มที่ด้านขวา
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
                  SizedBox(width: 5,),
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
                  SizedBox(width: 5,),
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

            SizedBox(height: 5,),

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
              )
            ),

            SizedBox(height: 5,),

            Container(
              margin: const EdgeInsets.only(left: 15),
              child: AppText(text: "รายการเข้าร่วมกิจกรรม", size: 20,),
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
                    itemCount: 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
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
                      );
                    }
                  ),

                  ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
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
                      );
                    }
                  ),

                  ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
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
                      );
                    }
                  ),

                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
