import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class trackwidget extends StatefulWidget {
  const trackwidget({required this.snapData, super.key});
  final snapData;

  @override
  State<trackwidget> createState() => _trackwidgetState();
}

class _trackwidgetState extends State<trackwidget> {
  bool approval = true;
  String username = '';
  void fetch() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users Data')
        .where('uuid', isEqualTo: widget.snapData['uuid'])
        .get();
    print(snapshot.docs.length);
    if (snapshot.docs.isNotEmpty) {
      setState(() {
        username = snapshot.docs[0]['name'];
      });
    }
  }

  @override
  initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final date = widget.snapData['Leavedate'][0] as Timestamp;
    final formattedate = DateFormat.MMMd().format(date.toDate());
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Container(
            height: size.height * 0.08,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Color(0xff1c1c1e),
              border: Border.all(
                color: const Color(0xff1c1c1e),
              ),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://c0.wallpaperflare.com/preview/367/1014/409/bridge-man-person-trees.jpg'),
                  ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  Text(
                    username,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.10,
                  ),
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Color(0xffffffff),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      formattedate,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.12,
                  ),
                  widget.snapData['isCancelled']
                      ? Icon(
                          Icons.dangerous_outlined,
                          color: Colors.red,
                        )
                      : widget.snapData['quickapproval']
                          ? Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: size.width * 0.04,
                                  height: size.height * 0.04,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff009e10),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.check,
                                  size: 10,
                                  color: Color(0xffffffff),
                                ),
                              ],
                            )
                          : Icon(
                              Icons.access_time,
                              color: Color(0xffffffff),
                            ),
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  widget.snapData['isCancelled']
                      ? Text(
                          'Reject',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        )
                      : widget.snapData['quickapproval']
                          ? Text(
                              'Approved',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff009e10),
                              ),
                            )
                          : Text(
                              'pending',
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
        ),
        SizedBox(
          height: size.height * 0.02,
        )
      ],
    );
  }
}
