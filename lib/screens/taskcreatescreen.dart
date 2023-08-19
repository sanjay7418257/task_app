import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/Modal/taskcreate.dart';
import 'package:uuid/uuid.dart';

import '../Modal/applyleave_notify.dart';
import '../Modal/remind.dart';
import 'calendarpopup.dart';
import 'homescreen.dart';
import 'homewidget.dart';
import 'taskcreatecalendarpopup.dart';

class taskcreate extends StatefulWidget {
  const taskcreate({super.key});

  @override
  State<taskcreate> createState() => _taskcreateState();
}

class _taskcreateState extends State<taskcreate> {
  String appliedUsername = '';
  Future<void> taskNotify() async {
    NotifyAccess notifyvalue = NotifyAccess.appliedStatus;
    String enumValue = notifyvalue.toString();
    var snapshot = await FirebaseFirestore.instance
        .collection('Users Data')
        .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      appliedUsername = snapshot.docs[0]['name'];
    });
    var i = uuid.v4();
    var authority = [
      'emafeJG9nuPB2pZB7mSGRJ7owJn2',
      '1vTCmEi5VLS3SSiuc223k9FlaUN2',
    ];
    var s = 0;
    for (s; s <= authority.length - 1; s++) {
      var a = ApplyLeaveNotify(
        name: '$appliedUsername applied for leave',
        leaveDate: [],
        alternateDate: [],
        id: i,
        image: '',
        senderUid: FirebaseAuth.instance.currentUser!.uid,
        recieverUid: authority[s],
        notifyStatus: enumValue,
        notifyBody: appliedUsername,
        createdDate: DateTime.now(),
      );
      await FirebaseFirestore.instance
          .collection('Users Data')
          .doc(authority[s])
          .collection('Notification')
          .doc(i)
          .set(a.tojson());
    }
  }

  final createController = TextEditingController();
  final ReminderController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDate = focusedDay;
    });
  }

  List<DateTime> taskcreate = [];
  void cleartext() {
    createController.text = '';
    ReminderController.text = '';
  }

  var uuid = const Uuid();
  bool isopencalendar = false;
  String formattedDate = DateFormat.MMMd().format(DateTime.now());
  String taskname = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent,
      //height: size.height * 0.3,
      //padding: EdgeInsets.only(left: size.width * 0.55),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.32,
          vertical: size.height * 0.1,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xff1c1c1e),
        ),
        height: size.height * 0.08,
        width: size.width * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Color(0xff1c1c1e),
                            title: const Text(
                              'Task Create',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffffffff),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            scrollable: true,
                            content: StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  height: size.height * 0.36,
                                  width: size.width * 0.9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Task Name',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        height: size.height * 0.06,
                                        child: TextFormField(
                                          controller: createController,
                                          cursorColor: const Color(0xffffffff),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffffffff),
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xfffffffff),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xfffffffff),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Text(
                                        'Add Date,Time',
                                        style: TextStyle(
                                          color: Color(0xffffffff),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return taskcalendar();
                                            },
                                          ).then((value) => setState(() {
                                                _selectedDate = value;
                                                // Navigator.pop(context);
                                              }));
                                        },
                                        child: Container(
                                          height: size.height * 0.06,
                                          width: size.width * 0.9,
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color(0xffffffff),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.access_time,
                                                color: Color(0xffffffff),
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              Text(
                                                '10 am - 1 pm',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xffffffff),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.03,
                                              ),
                                              Icon(
                                                Icons.calendar_month_outlined,
                                                color: Color(0xffffffff),
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: size.width * 0.01,
                                              ),
                                              Text(
                                                DateFormat('MMM dd')
                                                    .format(_selectedDate),
                                                // _selectedDate.toString(),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color(0xffffffff),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      Text(
                                        'Add People',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: size.width * 0.06,
                                            height: size.height * 0.06,
                                            decoration: BoxDecoration(
                                              color: Color(0xff5200ff),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Color(0xff5200ff),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            color: Color(0xfffffffff),
                                            Icons.add,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(0xff5200ff),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            // textStyle: const TextStyle(
                                            //   fontSize: 16,
                                            //   fontWeight: FontWeight.w500,
                                            // ),
                                            fixedSize: Size(size.width * 0.28,
                                                size.height * 0.05),

                                            elevation: 8,
                                          ),
                                          onPressed: () async {
                                            var i = uuid.v4();
                                            taskname =
                                                createController.text.trim();
                                            var a = creating(
                                                selectedDay: _selectedDate,
                                                taskname: taskname,
                                                id: i,
                                                addpeople: [],
                                                createdDate: DateTime.now(),
                                                extranotes: 'Fetching Data',
                                                percent: 10,
                                                name: []);
                                            await FirebaseFirestore.instance
                                                .collection('task create')
                                                .doc(i)
                                                .set(a.tojson());
                                            taskNotify();
                                            cleartext();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        homeScreen()));
                                          },
                                          child: const Text(
                                            'SUBMIT',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.check_circle_outline_outlined,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const Text(
                  'Task',
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Color(0xff1c1c1e),
                              title: const Text(
                                'Add Reminder',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              scrollable: true,
                              content: StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    height: size.height * 0.30,
                                    width: size.width * 0.9,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Reminder',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Color(0xffffffff),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Container(
                                          height: size.height * 0.06,
                                          child: TextFormField(
                                            controller: ReminderController,
                                            cursorColor:
                                                const Color(0xffffffff),
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffffffff),
                                            ),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xfffffffff),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color(0xfffffffff),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Text(
                                          'Add Date,Time',
                                          style: TextStyle(
                                            color: Color(0xffffffff),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return calendar();
                                              },
                                            ).then((value) => setState(() {
                                                  _selectedDate = value;
                                                  // Navigator.pop(context);
                                                }));
                                          },
                                          child: Container(
                                            height: size.height * 0.06,
                                            width: size.width * 0.9,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xffffffff),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Color(0xffffffff),
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.01,
                                                ),
                                                Text(
                                                  '10 am - 1 pm',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xffffffff),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.03,
                                                ),
                                                Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Color(0xffffffff),
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.01,
                                                ),
                                                Text(
                                                  DateFormat('MMM dd')
                                                      .format(_selectedDate),
                                                  // _selectedDate.toString(),
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xffffffff),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.04,
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: const Color(0xff5200ff),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              // textStyle: const TextStyle(
                                              //   fontSize: 16,
                                              //   fontWeight: FontWeight.w500,
                                              // ),
                                              fixedSize: Size(size.width * 0.28,
                                                  size.height * 0.05),

                                              elevation: 8,
                                            ),
                                            onPressed: () async {
                                              var i = uuid.v4();
                                              var a = reminder(
                                                remind: ReminderController.text,
                                                selectedDate: _selectedDate,
                                                createdDate: DateTime.now(),
                                                isCompleted: false,
                                                id: i,
                                                uuid: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                              );
                                              await FirebaseFirestore.instance
                                                  .collection('Reminder')
                                                  .doc(i)
                                                  .set(a.tojson());
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          homeScreen()));
                                            },
                                            child: const Text(
                                              'SUBMIT',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          });
                    },
                    child: const Icon(
                      Icons.bookmark_border_sharp,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const Text(
                  'Reminder',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xfffffffff),
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
