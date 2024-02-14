import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';

class activity_results_screen1 extends StatefulWidget {
  @override
  _activity_results_screen1State createState() =>
      _activity_results_screen1State();
}

class _activity_results_screen1State extends State<activity_results_screen1> {
  late Future<dynamic> futureActivity;
  final LocalStorage storage = LocalStorage('user_profile');

  @override
  void initState() {
    super.initState();
    futureActivity = registerActivity('act_id');
  }

  Future<dynamic> registerActivity(String activity) async {
    final String apiUrl =
        'http://127.0.0.182/api_club_app/show_User_Activity1.php';

    try {
      await storage.ready;
      // Get mb_id from LocalStorage
      final Map<String, dynamic>? userData = storage.getItem('user_profile');
      final String? mbId = userData?['userId'];

      if (mbId == null) {
        print('Error: mb_id not found in LocalStorage.');
        return 'Error: mb_id not found in LocalStorage.';
      }

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mb_id': mbId, // Use mbId retrieved from LocalStorage
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['camp_data'];
      } else {
        print('Unexpected data format');
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred: $e');
      return 'Exception occurred: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('รายการกิจกรรม'),
        ),
        body: FutureBuilder<dynamic>(
          future: futureActivity,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<dynamic> campData = snapshot.data;
              return ListView.builder(
                itemCount: campData.length,
                itemBuilder: (context, index) {
                  return buildActivityCard(campData[index]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildActivityCard(Map<String, dynamic> acData) {
    String name = acData['act_name'] ?? '';
    String location = acData['act_location'] ?? '';
    String year = acData['act_year']?.toString() ?? '';
    String credit = acData['act_credit']?.toString() ?? '';

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.green,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Image.asset(
          'assate/images/act_03.png',
          fit: BoxFit.cover,
          width: 100,
          height: 170,
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.red,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Name: $name\n'
          'Location: $location\n'
          'Date: $year\n'
          'Registrations: $credit',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
