import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class myaccount extends StatefulWidget {
  const myaccount({super.key});

  @override
  State<myaccount> createState() => _myaccountState();
}

class _myaccountState extends State<myaccount> {
  String username = '';

  void getDetail() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users Data')
        .where('uuid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = snapshot.docs[0]['name'];
    });
    print(snapshot.docs[0]['name']);
  }

  @override
  initState() {
    getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListTile(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Container(
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                  color: Color(0xff17141f),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(14),
                    topLeft: Radius.circular(14),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: const [
                          CircleAvatar(
                            radius: 48,
                            backgroundImage: NetworkImage(
                              'https://c0.wallpaperflare.com/preview/367/1014/409/bridge-man-person-trees.jpg',
                            ),
                          ),
                          CircleAvatar(
                            radius: 11,
                            backgroundColor: Color(0xffffffff),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Color(0xff5200ff),
                              child: Icon(
                                Icons.add,
                                size: 13,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff17141f),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Color(0xffffffff),
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          fixedSize:
                              Size(size.width * 0.28, size.height * 0.05),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Color(0xff4994ec),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      title: const Text(
        'My Account',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xffffffff),
        ),
      ),
    );
  }
}
