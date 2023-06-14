import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class workingdays extends StatefulWidget {
  const workingdays({required this.select, super.key});
  final select;
  @override
  State<workingdays> createState() => _workingdaysState();
}

class _workingdaysState extends State<workingdays> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          height: size.height * 0.05,
          width: size.width * 0.20,
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xffffffff),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            DateFormat.MMMd().format(widget.select),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xffffffff),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.03,
        ),
        // Container(
        //   height: size.height * 0.05,
        //   width: size.width * 0.20,
        //   padding: const EdgeInsets.all(11),
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: const Color(0xffffffff),
        //     ),
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   child: const Text(
        //     'Oct 20',
        //     style: TextStyle(
        //       fontSize: 13,
        //       fontWeight: FontWeight.w400,
        //       color: Color(0xffffffff),
        //     ),
        //   ),
        // ),
        // SizedBox(
        //   width: size.width * 0.03,
        // ),
      ],
    );
  }
}
