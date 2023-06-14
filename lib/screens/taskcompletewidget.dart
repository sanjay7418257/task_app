import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math';

import 'package:task_app/screens/taskcomplete.dart';

class taskcompletewidget extends StatefulWidget {
  final snap;
  final taskid;
  const taskcompletewidget({this.snap, super.key, this.taskid});

  @override
  State<taskcompletewidget> createState() => _taskcompletewidgetState();
}

class _taskcompletewidgetState extends State<taskcompletewidget> {
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDate = day;
    });
  }

  var colors = [
    const Color(0xff6342D8),
    const Color(0xff4994ec),
    const Color(0xff53b27e),
    const Color(0xffe4a70a),
    const Color(0xff03710e),
    const Color(0xff00b589),
  ];
  final _random = Random();
  bool isopencalendar = false;
  bool valuefirst = false;
  bool isDelete = false;
  bool isLoading = false;
  DateTime _selectedDate = DateTime.now();
  Future<void> getSwitchStatus() async {
    var s = await FirebaseFirestore.instance
        .collection('task create')
        .doc(widget.taskid)
        .collection('steps')
        .doc(widget.snap['id'])
        .get();
    setState(() {
      isDelete = s.data()!['iscompleted'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getSwitchStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final date = widget.snap['selectedDate'] as Timestamp;
    final formattedate = DateFormat.MMMd().format(date.toDate());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!isDelete)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.access_time,
                  size: 20,
                  color: Color(0xffffffff),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                const Text(
                  '10 am - 1 pm',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffffffff),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.03,
                ),
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                  color: Color(0xffffffff),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Text(
                  formattedate,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        if (!isDelete)
          Row(
            children: [
              InkWell(
                onTap: () async {
                  setState(() {
                    valuefirst = !valuefirst;
                  });
                  await Future.delayed(Duration(seconds: 3)).then((value) {
                    if (mounted) {
                      setState(() {
                        isDelete = true;
                      });
                    }
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Item deleted'),
                      action: SnackBarAction(
                        label: 'undo',
                        onPressed: () {
                          if (mounted) {
                            setState(() {
                              isDelete = false;
                            });
                          }
                        },
                      ),
                    ),
                  );
                  await Future.delayed(Duration(seconds: 5))
                      .then((value) async {
                    if (isDelete) {
                      await FirebaseFirestore.instance
                          .collection('task create')
                          .doc(widget.taskid)
                          .collection('steps')
                          .doc(widget.snap['id'])
                          .update({'iscompleted': true});
                    }
                  });
                  // await Future.delayed(Duration(seconds: 5)).then((value) async {
                  //   if (isDelete) {
                  //     var snapshot = await FirebaseFirestore.instance
                  //         .collection('task create')
                  //         .doc(widget.snap['name'])
                  //         .update({'name': FieldValue.delete()});
                  //   }
                  // });
                },
                child: Container(
                  width: size.width * 0.12,
                  height: size.height * 0.06,
                  padding: const EdgeInsets.all(14.0),
                  margin: const EdgeInsets.only(
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6),
                    ),
                    color: valuefirst
                        ? Color(0xff1c1c1e)
                        : colors[_random.nextInt(6)],
                  ),
                  child: Container(
                    width: size.width * 0.05,
                    height: size.height * 0.10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: valuefirst ? Colors.green : Colors.transparent,
                      border: Border.all(
                        color: valuefirst ? Colors.green : Colors.white,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height * 0.06,
                width: size.width * 0.80,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                  color: Color(0xff1c1c1e),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 14,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.snap['name'],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffffffff),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isopencalendar = !isopencalendar;
                          });
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: Color(
                            0xffffffff,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        if (!isDelete)
          if (isopencalendar)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff1c1c1e),
              ),
              child: TableCalendar(
                rowHeight: 40,
                firstDay: DateTime.now(),
                focusedDay: _selectedDate,
                lastDay: DateTime(2025),
                selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                headerStyle: const HeaderStyle(
                  formatButtonDecoration: BoxDecoration(
                    color: Color(0xffffffff),
                  ),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  titleTextStyle: TextStyle(
                    color: Color(0xffffffff),
                  ),
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: const CalendarStyle(
                  defaultTextStyle: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 14,
                  ),
                  outsideDaysVisible: false,
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff04296E),
                  ),
                  isTodayHighlighted: false,
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff04296e),
                  ),
                  tablePadding: EdgeInsets.symmetric(
                    horizontal: 1,
                    vertical: 3,
                  ),
                ),
                headerVisible: true,
                availableGestures: AvailableGestures.all,
                onDaySelected: _onDaySelected,
              ),
            ),
        if (isopencalendar)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff1c1c1e),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    fixedSize: Size(size.width * 0.28, size.height * 0.05),
                  ),
                  onPressed: () {},
                  child: const Text('Back'),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff5200ff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    fixedSize: Size(size.width * 0.28, size.height * 0.05),
                  ),
                  onPressed: () async {
                    showLoaderDialog(context);
                    await FirebaseFirestore.instance
                        .collection('task create')
                        .doc(widget.taskid)
                        .collection('steps')
                        .doc(widget.snap['id'])
                        .update({'selectedDate': _selectedDate});
                    setState(() {
                      isopencalendar = !isopencalendar;
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Text('Apply'),
                ),
              ],
            ),
          ),
      ],
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Color(0xff1c1c1e),
      content: Row(
        children: [
          CircularProgressIndicator(
            color: Color(0xffffffffff),
          ),
          Container(
            color: Color(0xff1c1c1e),
            margin: EdgeInsets.only(left: 7),
            child: Text(
              'Loading...',
              style: TextStyle(color: Color(0xffffffff)),
            ),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
