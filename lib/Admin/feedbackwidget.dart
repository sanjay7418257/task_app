import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_app/Admin/adminleave.dart';

class feedbackwidget extends StatefulWidget {
  final feedbackdata;
  const feedbackwidget({required this.feedbackdata, super.key});

  @override
  State<feedbackwidget> createState() => _feedbackwidgetState();
}

class _feedbackwidgetState extends State<feedbackwidget> {
  bool seedetails = false;
  String username = '';
  void getUser() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users Data')
        .where('uuid', isEqualTo: widget.feedbackdata['uuid'])
        .get();
    setState(() {
      username = snapshot.docs[0]['name'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Uint8List? imageData;
    String base64String = widget.feedbackdata['signaturedpad'];
    setState(() {
      imageData = base64Decode(base64String);
    });
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.010,
          ),
          child: Container(
            height: seedetails ? size.height * 0.8 : size.height * 0.080,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xff1c1c1e),
              border: Border.all(
                color: const Color(0xff1c1c1e),
              ),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.01),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://c0.wallpaperflare.com/preview/367/1014/409/bridge-man-person-trees.jpg'),
                        ),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02),
                          child: SizedBox(
                            width: 35,
                            child: Text(
                              softWrap: false,
                              overflow: TextOverflow.visible,
                              username,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.01),
                          child: const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xffffffff),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.height * 0.02),
                          child: const SizedBox(
                            width: 35,
                            child: Text(
                              'Oct 19',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.12,
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              seedetails = !seedetails;
                            });
                          },
                          child: const Text(
                            'See Details',
                            style: TextStyle(
                              color: Color(0xff4994ec),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (seedetails)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.01,
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              var snapshot = await FirebaseFirestore.instance
                                  .collection('Feedback')
                                  .where('id',
                                      isEqualTo: widget.feedbackdata['id'])
                                  .get();
                              await snapshot.docs.first.reference.delete();
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => adminleave()));
                            },
                            child: const Icon(
                              Icons.delete_outline_outlined,
                              color: Color(0xffff8282),
                            ),
                          ),
                        ),
                        if (seedetails)
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                        if (seedetails)
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                            ),
                            child: const Icon(
                              Icons.file_download_outlined,
                              color: Color(0xffffffff),
                            ),
                          ),
                        if (seedetails)
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                              left: size.width * 0.04,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  seedetails = !seedetails;
                                });
                              },
                              child: const Icon(
                                Icons.close_outlined,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                      ],
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    const Text(
                      'Colleagues Name',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  if (seedetails)
                    Container(
                      height: size.height * 0.05,
                      width: size.width * 0.74,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffffffff),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.feedbackdata['colleaguesname'],
                          style: const TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    const Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  if (seedetails)
                    Container(
                      height: size.height * 0.15,
                      width: size.width * 0.74,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffffffff),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          widget.feedbackdata['feedback'],
                          style: const TextStyle(
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Colleagues ratings",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffffffff),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          if (seedetails)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: widget.feedbackdata['one']
                                      ? const Color(0xffffb800)
                                      : const Color(0xffffffff),
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Icon(
                                  Icons.star,
                                  color: widget.feedbackdata['two']
                                      ? const Color(0xffffb800)
                                      : const Color(0xffffffff),
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Icon(Icons.star,
                                    color: widget.feedbackdata['three']
                                        ? const Color(0xffffb800)
                                        : const Color(0xffffffff)),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Icon(
                                  Icons.star,
                                  color: widget.feedbackdata['four']
                                      ? const Color(0xffffb800)
                                      : const Color(0xffffffff),
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Icon(
                                  Icons.star,
                                  color: widget.feedbackdata['five']
                                      ? const Color(0xffffb800)
                                      : const Color(0xffffffff),
                                ),
                              ],
                            )
                        ],
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                  if (seedetails)
                    const Text(
                      'Signature',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  if (seedetails)
                    Container(
                      height: size.height * 0.20,
                      width: size.width * 0.74,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xffffffff),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.memory(imageData!),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (seedetails)
          SizedBox(
            height: size.height * 0.01,
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
