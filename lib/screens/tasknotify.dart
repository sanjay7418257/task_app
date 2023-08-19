import 'package:flutter/material.dart';

class TaskNotify extends StatelessWidget {
  TaskNotify({super.key});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.9,
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffffffff),
          ),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ' task was created',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
              ),
              Text(
                '24/11/22',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
