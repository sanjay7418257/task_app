import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app/Drawer/drawerwidget.dart';
import 'package:task_app/Drawer/myaccount.dart';
import 'package:task_app/screens/chatscreen.dart';
import 'package:task_app/screens/homewidget.dart';
import 'package:task_app/screens/listscreen.dart';
import 'package:task_app/screens/taskcreatescreen.dart';

import '../Drawer/feedback.dart';
import 'notification.dart';

class homeScreen extends StatefulWidget {
  final bool isShow;
  homeScreen({this.isShow = false, super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  final TextEditingController _notes = TextEditingController();
  bool valuefirst = false;
  var screens = [
    homewidget(),
    listscreen(),
    listscreen(),
    chatscreen(),
  ];
  @override
  int initialpage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => notificationpage())));
                },
                icon: const Icon(
                  Icons.notifications_none_sharp,
                ),
              ),
              Positioned(
                right: 10,
                top: 14,
                child: Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: widget.isShow
                          ? Color(0xffffffff)
                          : Colors.transparent),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: drawerwidget(),
      body: screens[initialpage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        backgroundColor: const Color(0xff1a1920),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              backgroundColor: Color(0xff1a1920),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_outlined),
              backgroundColor: Color(0xff1a1920),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              backgroundColor: Color(0xff1a1920),
              label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              backgroundColor: Color(0xff1a1920),
              label: ''),
        ],
      ),
    );
  }

  void _onTap(int index) {
    index == 2
        ? showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => taskcreate(),
          )
        : setState(() {
            initialpage = index;
          });
  }
}
