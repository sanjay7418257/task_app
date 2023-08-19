import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'taskcomplete.dart';

class listscreen extends StatelessWidget {
  listscreen({
    super.key,
  });
  final List<String> name = [
    'Landing Page Design',
    'Notes App',
    'Creating',
    'Landing Page Design',
    'Notes App',
    'Creating',
  ];
  var colors = [
    const Color(0xff6342D8),
    const Color(0xff4994ec),
    const Color(0xff53b27e),
    const Color(0xffe4a70a),
    const Color(0xff03710e),
    const Color(0xff00b589),
  ];
  final _random = Random();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Task list',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            FutureBuilder(
              future:
                  FirebaseFirestore.instance.collection('task create').get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final date = snapshot.data!.docs[index]['selectedDay']
                          as Timestamp;
                      final formattedate =
                          DateFormat.MMMd().format(date.toDate());
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => taskcomplete(
                                    querySnapshot: snapshot.data!.docs[index],
                                  )));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          height: size.height * 0.07,
                          child: Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: colors[_random.nextInt(6)],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['taskname'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(
                                        0xFFFFFFFF,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
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
                                      color: Color(
                                        0xffffffff,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 16,
                                    color: Color(0xffffffff),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                    formattedate,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(
                                        0xffffffff,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
