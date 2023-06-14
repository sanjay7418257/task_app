import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'historywidget.dart';
import 'trackwidget.dart';

class trackpage extends StatefulWidget {
  const trackpage({super.key});

  @override
  State<trackpage> createState() => _trackpageState();
}

class _trackpageState extends State<trackpage> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.09,
              vertical: size.height * 0.02,
            ),
            child: const Text(
              'Applied Leave',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          //
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('Leave details')
                .where('uuid',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                height: size.height * 0.3,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return trackwidget(
                      snapData: snapshot.data!.docs[index],
                    );
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.09,
              vertical: size.height * 0.02,
            ),
            child: const Text(
              'History',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Column(
            children: List.generate(
              2,
              (index) => historywidget(),
            ),
          )
        ],
      ),
    );
  }
}
