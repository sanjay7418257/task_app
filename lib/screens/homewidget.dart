import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_app/Modal/remind.dart';
import 'package:task_app/screens/taskcomplete.dart';

import '../Modal/notes.dart';
import 'reminderscreen.dart';
import 'package:uuid/uuid.dart';

class homewidget extends StatefulWidget {
  const homewidget({super.key});

  @override
  State<homewidget> createState() => _homewidgetState();
}

class _homewidgetState extends State<homewidget> with WidgetsBindingObserver {
  @override
  bool _shouldDisplay = false;
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    notes.dispose();
    createController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    fetch();
    // notes = TextEditingController(text: username);
    super.initState();
  }

  String username = '';
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    print('state $state');
    if (state == AppLifecycleState.paused) {
      if (notes.text.isNotEmpty) notesupdate();
    }
    //else {
    //   notesupdate();
    // }
    // if (state == AppLifecycleState.inactive ||
    //     state == AppLifecycleState.paused) return;
    if (state == AppLifecycleState.resumed) {
      fetch();
    }
    //else {
    //   var snapshot = await FirebaseFirestore.instance.collection('notes').get();
    //   print(snapshot.docs);
    //   setState(() {
    //     _notes.text = snapshot.docs[0]['notes'];
    //   });
    // }
  }

  List<String> listed = [];
  bool isloading = false;
  void fetch() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('notes')
        .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      notes.text = snapshot.docs[0]['notes'];
      isloading = false;
    });
  }

  void notesupdate() async {
    var snap = await FirebaseFirestore.instance
        .collection('notes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snap.exists) {
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'notes': notes.text});
    } else {
      var i = uuid.v4();
      var a = note(
        notes: notes.text,
        createdDate: DateTime.now(),
        uuid: FirebaseAuth.instance.currentUser!.uid,
        id: i,
      );
      await FirebaseFirestore.instance
          .collection('notes')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(a.tojson());
    }
  }

  var uuid = const Uuid();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _selectedDate = day;
    });
  }

  DateTime _selectedDate = DateTime.now();
  TextEditingController notes = TextEditingController();
  final TextEditingController _search = TextEditingController();
  final TextEditingController createController = TextEditingController();
  bool valuefirst = false;
  final CollectionReference myCollection =
      FirebaseFirestore.instance.collection('task create');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: isloading
          ? CircularPercentIndicator(
              radius: 20,
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Container(
                        height: size.height * 0.06,
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 3,
                        ),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          style: const TextStyle(color: Color(0xffFFFFFF)),
                          controller: _search,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(top: 4),
                              border: InputBorder.none,
                              fillColor: const Color(0xFF1C1C1E),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(17)),
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
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 18),
                      child: Text(
                        'Task list',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('task create')
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: size.height * 0.19, //change the height
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final date = snapshot.data!.docs[index]
                                    ['selectedDay'] as Timestamp;
                                final formattedate =
                                    DateFormat.MMMd().format(date.toDate());
                                if (snapshot.hasError) {
                                  return const Text('something went wrong');
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => taskcomplete(
                                                  querySnapshot: snapshot
                                                      .data!.docs[index],
                                                )));
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => taskcomplete(
                                    //         querySnapshot: snapshot.data)));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.025),
                                    width: size.width * 0.55,
                                    height: size.height * 0.2,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4994EC),
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02,
                                          vertical: size.height * 0.014),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                                ['taskname'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.005,
                                            ),
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['Extranotes'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(0xFFDADADA),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.008,
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.006,
                                                ),
                                                Text(
                                                  '10 am - 1 pm',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(
                                                      0xFFFFFFFF,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.014,
                                                ),
                                                Icon(
                                                  Icons.calendar_month_outlined,
                                                  color: Color(0xFFFFFFFF),
                                                  size: 16,
                                                ),
                                                SizedBox(
                                                  width: size.width * 0.006,
                                                ),
                                                Text(
                                                  formattedate,
                                                  // DateFormat('MMM dd').format(
                                                  //     snapshot.data!
                                                  //         .docs[index]['selectedDay']
                                                  //         .toDate),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 10,
                                                    color: Color(
                                                      0xFFFFFFFF,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.008,
                                          ),
                                          SizedBox(
                                            width: size.width * 1.0,
                                            child: Stack(
                                              alignment: Alignment.centerLeft,
                                              children: const <Widget>[
                                                CircleAvatar(
                                                  radius: 10,
                                                  backgroundColor: Colors.red,
                                                ),
                                                Positioned(
                                                  left: 15,
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 25,
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                      '+5',
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: size.height * 0.016),
                                          LinearPercentIndicator(
                                            padding: EdgeInsets.only(
                                                right: size.width * 0.00),
                                            leading: null,
                                            alignment: MainAxisAlignment.center,
                                            width: size.width * 0.46,
                                            lineHeight: 5.0,
                                            percent: snapshot.data!.docs[index]
                                                    ['percent'] /
                                                100,
                                            barRadius:
                                                const Radius.circular(10),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    47, 47, 58, 0),
                                            progressColor: Colors.white,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.010,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data!
                                                    .docs[index]['percent']
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Reminder',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),

                    // Column(
                    //   children: List.generate(1, (index) => reminderScreen()),
                    // ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('Reminder')
                          .where('uuid',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return reminderScreen(
                                snapped: snapshot.data!.docs[index],
                              );
                            },
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'My Notes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Center(
                        child: TextFormField(
                          strutStyle: const StrutStyle(),
                          textAlign: TextAlign.start,
                          controller: notes,
                          cursorColor: const Color(0xffffffff),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffffffff),
                          ),
                          maxLines: null,
                          minLines: 8,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              fillColor: const Color(0xff1c1c1e),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 15),
                              hintText: 'Notes...',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              border: InputBorder.none
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.all(
                              //     Radius.circular(10),
                              //   ),
                              //   borderSide: BorderSide(
                              //     color: Color(
                              //       0xff5200ff,
                              //     ),
                              //     style: BorderStyle.none,
                              //   ),
                              // ),
                              ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
