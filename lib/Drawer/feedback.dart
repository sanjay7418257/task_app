import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:task_app/Modal/feedbackmodal.dart';
import 'package:uuid/uuid.dart';
import 'dart:ui' as ui;
import '../Modal/applyleave_notify.dart';
import 'ratingwidget.dart';

class feedback extends StatefulWidget {
  const feedback({super.key});

  @override
  State<feedback> createState() => _feedbackState();
}

class _feedbackState extends State<feedback> {
  void cleartext() {
    _feedback.text = '';
    _colleagues.text = "";
  }

  bool one = false;
  bool two = false;
  bool three = false;
  bool four = false;
  bool five = false;
  var uuid = const Uuid();
  TextEditingController _feedback = TextEditingController();
  TextEditingController _colleagues = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String appliedUsername = '';
    Future<void> FeedbackNotify() async {
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
        'OebtkLEqFMNVE6O4AivOJG4ixKq2',
        'yBv3E1fQ2wT2hKJ1UVl2wgksUTl2'
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

    GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.7),
              child: const Text(
                'FeedBack',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.6),
              child: const Text(
                'Colleagues Name',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: TextFormField(
                controller: _colleagues,
                cursorColor: const Color(0xffffffff),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
                decoration: InputDecoration(
                  hintText: 'Colleagues full name',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xfffffffff),
                    ),
                    borderRadius: BorderRadius.circular(10),
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
            SizedBox(
              height: size.height * 0.04,
            ),
            const Text(
              'Feedback',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xffffffff),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: TextFormField(
                controller: _feedback,
                cursorColor: const Color(0xffffffff),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  fillColor: const Color(0xff00000000),
                  filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
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
              height: size.height * 0.05,
            ),
            const Text(
              'Your Colleagues ratings',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xffffffff),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.star),
                  color: one ? Colors.yellow : Colors.grey,
                  onPressed: () {
                    setState(() {
                      one = !one;
                      two = false;
                      three = false;
                      four = false;
                      five = false;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: two ? Colors.yellow : Colors.grey,
                  onPressed: () {
                    setState(() {
                      one = true;
                      two = !two;
                      three = false;
                      four = false;
                      five = false;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: three ? Colors.yellow : Colors.grey,
                  onPressed: () {
                    setState(() {
                      one = true;
                      two = true;
                      three = !three;
                      four = false;
                      five = false;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: four ? Colors.yellow : Colors.grey,
                  onPressed: () {
                    setState(() {
                      one = true;
                      two = true;
                      three = true;
                      four = !four;
                      five = false;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star),
                  color: five ? Colors.yellow : Colors.grey,
                  onPressed: () {
                    setState(() {
                      one = true;
                      two = true;
                      three = true;
                      four = true;
                      five = !five;
                    });
                  },
                ),
              ],
            ),

            // Padding(
            //   padding: EdgeInsets.only(left: size.width * 0.20),
            //   child: Row(
            //     children: List.generate(
            //       5,
            //       (index) => ratingwidget(),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.05,
            ),
            const Text(
              'Your Signature',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xffffffff),
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Container(
                height: size.height * 0.20,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffffffff),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SfSignaturePad(
                  key: _signaturePadKey,
                  minimumStrokeWidth: 1,
                  maximumStrokeWidth: 3,
                  strokeColor: Color(0xffffffff),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.width * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () async {
                      _signaturePadKey.currentState!.clear();
                    },
                    child: Text(
                      'clear',
                      style: TextStyle(
                          color: Color(0xff5200ff),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
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
                    final data = await _signaturePadKey.currentState!
                        .toImage(pixelRatio: 3.0);
                    final bytes =
                        await data.toByteData(format: ui.ImageByteFormat.png);
                    final Uint8List signaturebytes =
                        await bytes!.buffer.asUint8List();
                    var i = uuid.v4();
                    var a = feedbackmodal(
                      colleaguesname: _colleagues.text,
                      feedback: _feedback.text,
                      createDate: DateTime.now(),
                      one: one,
                      two: two,
                      three: three,
                      four: four,
                      five: five,
                      id: i,
                      uuid: FirebaseAuth.instance.currentUser!.uid,
                      signaturepad: base64Encode(signaturebytes),
                    );
                    await FirebaseFirestore.instance
                        .collection('Feedback')
                        .doc(i)
                        .set(a.tojson());
                    await FirebaseFirestore.instance
                        .collection('Feedback')
                        .doc(i)
                        .update({
                      'one': one,
                      'two': two,
                      'three': three,
                      'four': four,
                      'five': five,
                    });
                    FeedbackNotify();
                    cleartext();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => feedback()));
                  },
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
}
