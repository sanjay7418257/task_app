import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import '../Modal/leavemodal.dart';
import '../screens/homescreen.dart';
import 'trackpage.dart';
import 'workingdays.dart';

class leavePage extends StatefulWidget {
  const leavePage({super.key});

  @override
  State<leavePage> createState() => _leavePageState();
}

class _leavePageState extends State<leavePage> {
  Color ccolor = Color(0xff5200ff);
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: "Developer",
        child: Text(
          "Developer",
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      const DropdownMenuItem(
        value: "HR",
        child: Text(
          "HR",
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    ];
    return menuItems;
  }

  var uuid = const Uuid();
  final reasonController = TextEditingController();
  String? SelectedValue = null;
  DateTime _selectedDate = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDate = day;
    });
  }

  List<DateTime> Alternatedate = [];
  List<DateTime> Leavedate = [];
  bool valuefirst = false;

  bool valueSecond = false;
  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  void cleartext() {
    reasonController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_sharp,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.08, vertical: size.height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Leave',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => trackpage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Track',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff5200ff),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.08, vertical: size.height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff1c1c1e),
              ),
              child: TableCalendar(
                rowHeight: 40,
                firstDay: DateTime.now(),
                focusedDay: _selectedDate,
                lastDay: DateTime(2025),
                selectedDayPredicate: (day) => Leavedate.contains(day),
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
                onDaySelected: (dates, events) {
                  setState(() {
                    if (Leavedate.contains(dates)) {
                      Leavedate.remove(dates);
                    } else {
                      Leavedate.add(dates);
                    }
                  });
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.09,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        valuefirst = true;
                        valueSecond = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: size.width * 0.04,
                      height: size.height * 0.04,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        color: valuefirst ? Color(0xff5200ff) : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        valuefirst = true;
                        valueSecond = false;
                      });
                    },
                    child: Text(
                      'Take Leave',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        valuefirst = false;
                        valueSecond = true;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: size.width * 0.04,
                      height: size.height * 0.04,
                      decoration: BoxDecoration(
                        color: valueSecond
                            ? const Color(0xff5200ff)
                            : Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        valuefirst = false;
                        valueSecond = true;
                      });
                    },
                    child: const Text(
                      'Work with Alternate Day',
                      style: TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   'selected Day: ${date.join(",")}',
            //   style: TextStyle(color: Color(0xffffffff)),
            // ),
            if (valueSecond)
              SizedBox(
                height: size.height * 0.03,
              ),
            if (valueSecond)
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.09),
                child: const Text(
                  'Alternate Working Days',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            SizedBox(
              height: size.height * 0.02,
            ),
            if (valueSecond)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: size.width * 0.09),
                      child: Row(
                        children: List.generate(
                          Alternatedate.length,
                          (index) => workingdays(select: Alternatedate[index]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.02,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17)),
                                  backgroundColor: Color(0xff1c1c1e),
                                  content: Container(
                                    height: size.height * 0.42,
                                    width: size.width * 1.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xff1c1c1e),
                                    ),
                                    child: TableCalendar(
                                      rowHeight: 40,
                                      firstDay: DateTime.now(),
                                      focusedDay: _selectedDate,
                                      lastDay: DateTime(2025),
                                      selectedDayPredicate: (day) =>
                                          Alternatedate.contains(day),
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
                                      onDaySelected: (dates, events) {
                                        setState(() {
                                          if (Alternatedate.contains(dates)) {
                                            Alternatedate.remove(dates);
                                          } else {
                                            Alternatedate.add(dates);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: size.width * 0.04,
                              height: size.height * 0.04,
                              decoration: BoxDecoration(
                                color: const Color(0xfffffffff),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Alternatedate.removeLast();
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: size.width * 0.04,
                            height: size.height * 0.04,
                            decoration: BoxDecoration(
                              color: const Color(0xfffffffff),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.remove,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (valueSecond)
              SizedBox(
                height: size.height * 0.03,
              ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.09),
              child: const Text(
                'Your Role',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              height: size.height * 0.07,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.09),
                child: DropdownButtonFormField(
                    style: TextStyle(color: Color(0xffffffff)),
                    itemHeight: null,
                    value: SelectedValue,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xffffffff),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Color(0xffffffff),
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xff1c1c1e),
                    ),
                    dropdownColor: Color(0xff1c1c1e),
                    borderRadius: BorderRadius.circular(20),
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        SelectedValue = newValue!;
                      });
                    }),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.09),
              child: const Text(
                'Reason',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: TextFormField(
                controller: reasonController,
                cursorColor: const Color(0xffffffff),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
                maxLines: null,
                minLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  fillColor: const Color(0xff00000000),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color(0xfffffffff),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color(0xfffffffff),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff5200ff),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    // textStyle: const TextStyle(
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.w500,
                    // ),
                    fixedSize: Size(size.width * 0.28, size.height * 0.05),

                    elevation: 8,
                  ),
                  onPressed: () async {
                    var i = uuid.v4();
                    var a = leavemodal(
                      reason: reasonController.text,
                      Alternatedate: Alternatedate,
                      Leavedate: Leavedate,
                      role: SelectedValue.toString(),
                      createdDate: DateTime.now(),
                      takeleave: valuefirst,
                      id: i,
                      approval: [],
                      isCancelled: false,
                      uuid: FirebaseAuth.instance.currentUser!.uid,
                      quickapproval: false,
                    );
                    if (valuefirst) {
                      await FirebaseFirestore.instance
                          .collection('Leave details')
                          .doc(i)
                          .set(a.tojson());
                      await FirebaseFirestore.instance
                          .collection('Leave details')
                          .doc(i)
                          .update({
                        'takeleave': valuefirst,
                        'approval': [
                          'OebtkLEqFMNVE6O4AivOJG4ixKq2',
                          'yBv3E1fQ2wT2hKJ1UVl2wgksUTl2'
                        ],
                      });
                    } else if (Leavedate.length == Alternatedate.length) {
                      await FirebaseFirestore.instance
                          .collection('Leave details')
                          .doc(i)
                          .set(a.tojson());
                      await FirebaseFirestore.instance
                          .collection('Leave details')
                          .doc(i)
                          .update({
                        'takeleave': valuefirst,
                        'approval': [
                          'OebtkLEqFMNVE6O4AivOJG4ixKq2',
                          'yBv3E1fQ2wT2hKJ1UVl2wgksUTl2'
                        ],
                      });
                    } else {
                      return showDialog(
                          context: context,
                          builder: ((context) {
                            return AlertDialog(
                              backgroundColor: Color(0xff1c1c1e),
                              title: Text(
                                'Leavedate and Alternatedate are not equal !',
                                style: TextStyle(
                                    color: Color(0xffffffffff), fontSize: 14),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Back',
                                      style:
                                          TextStyle(color: Color(0xff5200ff)),
                                    ))
                              ],
                            );
                          }));
                    }
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => homeScreen()));

                    cleartext();
                  },
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
