import 'package:clubapp_project/pages/first_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clubapp_project/widget/user_provider.dart';
import 'package:clubapp_project/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User_Provider()),
      ],
      child: MyApp(), // ปรับเพิ่ม MyApp() เป็น child ของ MultiProvider
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyApp",
      routes: AppRote.all,
      home: first_screen(),
    );
  }
}
