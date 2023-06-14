import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class notificationpage extends StatefulWidget {
  const notificationpage({super.key});

  @override
  State<notificationpage> createState() => _notificationpageState();
}

class _notificationpageState extends State<notificationpage> {
  String username = '';
  bool isShow = false;
  void fetch() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Announcement')
        .orderBy('createdDate', descending: true)
        .limit(1)
        .get();
    setState(() {
      isShow = true;
      username = snapshot.docs[0]['announcement'];
    });
  }

  Future<void> getStatus() async {
    var s = await FirebaseFirestore.instance.collection('1').doc('1').get();
    setState(() {
      isShow = s.data()!['announcement'];
      var a = DateTime.now()
          .difference(s.data()!['sendAnnouncementdate'].toDate())
          .inHours;
      if (a <= 24) {
        if (isShow) fetch();
      } else {
        isShow = false;
      }
    });
  }

  @override
  initState() {
    getStatus();
    // fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xffffffff),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isShow)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.09,
                    vertical: size.height * 0.02),
                child: const Text(
                  'Announcement',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
            if (isShow)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Container(
                  height: size.height * 0.20,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffffffff),
                    ),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Center(
                    child: Text(
                      username,
                      style: TextStyle(
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Container(
                height: size.height * 0.08,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffffffff),
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
                        'Maryam',
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
                      Text(
                        'Oct 19',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffffffff),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.12,
                      ),
                      Stack(
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
                          )
                        ],
                      ),
                      SizedBox(
                        width: size.width * 0.02,
                      ),
                      Text(
                        'Approved',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff009e10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.09, vertical: size.height * 0.02),
              child: const Text(
                'Today Task',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Container(
                height: size.height * 0.07,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffffffff),
                  ),
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Task in map',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffffffff),
                        ),
                      ),
                      Text(
                        '24/11/22',
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
          ],
        ),
      ),
    );
  }
}
