import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/screens/homescreen.dart';
import 'package:uuid/uuid.dart';

import 'taskcompletewidget.dart';

class taskcomplete extends StatefulWidget {
  final querySnapshot;
  taskcomplete({this.querySnapshot, super.key});

  @override
  State<taskcomplete> createState() => _taskcompleteState();
}

class _taskcompleteState extends State<taskcomplete> {
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDate = day;
    });
  }

  final createController = TextEditingController();
  void taskcreate() async {
    var id = Uuid().v4();
    await FirebaseFirestore.instance
        .collection('task create')
        .doc(widget.querySnapshot['id'])
        .collection('steps')
        .doc(id)
        .set({
      'id': id,
      'name': createController.text,
      'iscompleted': false,
      'selectedDate': _selectedDate,
      'createdDate': DateTime.now(),
    });
  }

  DateTime _selectedDate = DateTime.now();
  final TextEditingController _search = TextEditingController();
  bool _shouldDisplay = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => homeScreen()));
                    },
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical: 8,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      height: size.height * 0.08,
                      width: size.width * 0.85,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Color(0xffFFFFFF),
                        ),
                        controller: _search,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 3),
                            border: InputBorder.none,
                            fillColor: const Color(0xFF1C1C1E),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            hintText: "Search...",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              // Column(
              //   children: List.generate(
              //       widget.querySnapshot['name'].length,
              //       (i) => taskcompletewidget(
              //             snap: widget.querySnapshot['name'][i],
              //           )),
              // ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.6,
                ),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _shouldDisplay = !_shouldDisplay;
                    });
                  },
                  icon: Icon(Icons.add_circle_outlined),
                  label: Text(
                    'Add Steps',
                    style: TextStyle(color: Color(0xFF4994EC)),
                  ),
                ),
              ),
              if (_shouldDisplay)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: TextFormField(
                    controller: createController,
                    cursorColor: const Color(0xffffffff),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Working Task Name',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xfffffffff),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xfffffffff),
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
              if (_shouldDisplay)
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
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
                        isSameDay(day, _selectedDate),
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
              if (_shouldDisplay)
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
                          fixedSize:
                              Size(size.width * 0.28, size.height * 0.05),
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
                          fixedSize:
                              Size(size.width * 0.28, size.height * 0.05),
                        ),
                        onPressed: () async {
                          taskcreate();
                          cleartext();
                          setState(() {
                            _shouldDisplay = !_shouldDisplay;
                          });
                        },
                        child: const Text('Apply'),
                      ),
                    ],
                  ),
                ),
              SizedBox(
                height: size.height * 0.01,
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('task create')
                    .doc(widget.querySnapshot['id'])
                    .collection('steps')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: size.height * 0.75,
                      child: ListView.builder(
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          if (snapshot.data!.docs[index]['iscompleted'] ==
                              false) {
                            return taskcompletewidget(
                              snap: snapshot.data!.docs[index],
                              taskid: widget.querySnapshot['id'],
                            );
                          }
                          return SizedBox();
                        },
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),

              SizedBox(
                height: size.height * 0.5,
              )
            ],
          ),
        ),
      ),
    );
  }

  void cleartext() {
    createController.text = '';
  }
}
