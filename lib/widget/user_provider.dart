// User_Provider Model
import 'package:clubapp_project/widget/member_modal.dart';
import 'package:flutter/material.dart';

class User_Provider extends ChangeNotifier {
  Member _loggedInCustomer = Member(
    memberID: '',
    membername: '',
    memberEmail: '',
    memberTel: '',
  );

  Member get loggedInCustomer => _loggedInCustomer;

  void setLoggedInCustomer(Member member) {
    _loggedInCustomer = member;
    notifyListeners();
  }

  String _userId = ''; // เก็บค่า cus_no

  String get userId => _userId;

  // เพิ่มเมธอด getUserId ที่คืนค่า cus_no
  String getUserId() {
    return _userId;
  }

  void setUserId(String userId) {
    _userId = userId;
    notifyListeners();
  }
}