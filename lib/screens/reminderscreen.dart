import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/screens/homescreen.dart';
import 'package:task_app/screens/taskcreatescreen.dart';

class reminderScreen extends StatefulWidget {
  final snapped;
  const reminderScreen({required this.snapped, super.key});

  @override
  State<reminderScreen> createState() => _reminderScreenState();
}

class _reminderScreenState extends State<reminderScreen> {
  // List data = [];
  // void fetch() async {
  //   var snapshot =
  //       await FirebaseFirestore.instance.collection('Reminder').get();
  //   print(snapshot.docs.length);
  //   if (snapshot.docs.isNotEmpty) {
  //     setState(() {
  //       data = snapshot.docs[0]['remind'];
  //     });
  //     print('not working');
  //   }
  // }

  // @override
  // initState() {
  //   fetch();
  //   super.initState();
  // }
  bool isDelete = false;

  bool valuefirst = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final date = widget.snapped['selectedDate'] as Timestamp;
    final formattedate = DateFormat('dd/MM/yyyy').format(date.toDate());
    return Column(
      children: [
        if (!isDelete)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      valuefirst = !valuefirst;
                    });
                    await Future.delayed(Duration(seconds: 3)).then((value) {
                      setState(() {
                        isDelete = true;
                      });
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Item deleted'),
                        action: SnackBarAction(
                          label: 'undo',
                          onPressed: () {
                            setState(() {
                              isDelete = false;
                            });
                          },
                        ),
                      ),
                    );
                    await Future.delayed(Duration(seconds: 5))
                        .then((value) async {
                      if (isDelete) {
                        var snapshot = await FirebaseFirestore.instance
                            .collection('Reminder')
                            .where('id', isEqualTo: widget.snapped['id'])
                            .get();
                        await snapshot.docs.first.reference.delete();
                      }
                    });
                  },
                  child: Container(
                    width: size.width / 20.0,
                    height: size.height / 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: valuefirst ? Colors.green : Colors.black,
                      border: Border.all(
                        color: valuefirst ? Colors.black : Colors.white,
                        width: 1,
                      ),
                    ),
                    child: valuefirst
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          )
                        : null,
                  ),
                ),
                SizedBox(
                  width: size.width / 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.snapped['remind'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      formattedate,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (!isDelete)
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.09),
            child: const Divider(
              color: Color(0xFF524b4b),
              thickness: 1,
            ),
          ),
      ],
    );
  }
}
