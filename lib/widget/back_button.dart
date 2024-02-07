import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 25, 10, 2),
      child: Align(
        alignment: Alignment.centerRight, // จัดตำแหน่งปุ่มที่ด้านขวา
        child: Material(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(30),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              child: Text(
                "  กลับ  ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontFamily: "Maehongson",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}