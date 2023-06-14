import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/Admin/adminleave.dart';

import '../home/loginscreen.dart';
import 'feedback.dart';
import 'leavepage.dart';
import 'myaccount.dart';

class drawerwidget extends StatefulWidget {
  const drawerwidget({super.key});

  @override
  State<drawerwidget> createState() => _drawerwidgetState();
}

class _drawerwidgetState extends State<drawerwidget> {
  String username = '';
  bool value = false;
  void getDetail() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users Data')
        .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = snapshot.docs[0]['name'];
    });
    print(snapshot.docs[0]['name']);
  }

  void get() async {
    var snapshot = await FirebaseFirestore.instance.collection('1').get();
    setState(() {
      value = snapshot.docs[0]['isFeedback'];
      isLoading = true;
    });
  }

  @override
  initState() {
    get();
    getDetail();
    super.initState();
  }

  Future<void> _signOut() async {
    setState(() {
      showSpinner = true;
    });
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: ((context) => loginscreen())));
    } finally {
      setState(() {
        showSpinner = false;
      });
    }
  }

  bool showSpinner = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: const Color(0xFF000000),
      width: size.width * 0.7,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.06, horizontal: size.width * 0.04),
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {},
              leading: const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://c0.wallpaperflare.com/preview/367/1014/409/bridge-man-person-trees.jpg'),
              ),
              title: Text(
                username,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffffff),
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.clear_outlined,
                  size: 30,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const myaccount(),
            // const ListTile(
            //   leading: Icon(
            //     Icons.check_box,
            //     color: Color(0xffffffff),
            //   ),
            //   title: Text(
            //     'Feedback',
            //     style: TextStyle(
            //       color: Color(0xffffffff),
            //       fontSize: 15,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.02,
            ),
            if (value)
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => feedback()),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_box_outlined,
                        color: Color(0xffffffff),
                        size: 20,
                      ),
                      SizedBox(width: size.width * 0.01),
                      const Text(
                        'Feedback',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (value)
              SizedBox(
                height: size.height * 0.04,
              ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const leavePage()),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  children: [
                    const Icon(
                      Icons.work_off_outlined,
                      color: Color(0xffffffff),
                      size: 20,
                    ),
                    SizedBox(width: size.width * 0.01),
                    const Text(
                      'Leave',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const adminleave()),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  children: [
                    const Icon(
                      Icons.manage_accounts_sharp,
                      color: Color(0xffffffff),
                      size: 20,
                    ),
                    SizedBox(width: size.width * 0.01),
                    const Text(
                      'Admin',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Container(
                        padding: EdgeInsets.all(8),
                        height: size.height * 0.15,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Color(0xff1c1c1e),
                            borderRadius: BorderRadius.circular(13)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Are you sure want to logout !",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _signOut();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Color(0xffffffff)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Color(0xffffffff)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person_off_outlined,
                      color: Color(0xffffffff),
                      size: 20,
                    ),
                    SizedBox(width: size.width * 0.01),
                    const Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
