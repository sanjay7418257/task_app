import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/Modal/qucikapproval.dart';
import 'package:uuid/uuid.dart';

class leavewidget extends StatefulWidget {
  final snapped;

  const leavewidget({required this.snapped, super.key});

  @override
  State<leavewidget> createState() => _leavewidgetState();
}

class _leavewidgetState extends State<leavewidget> {
  bool seedetails = false;
  bool approval = false;
  bool reject = false;
  String username = '';
  void getUsername() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('Users Data')
        .where('uuid', isEqualTo: widget.snapped['uuid'])
        .get();
    setState(() {
      username = snapshot.docs[0]['name'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final date = widget.snapped['createdDate'] as Timestamp;
    final createdDate = DateFormat.MMMd().format(date.toDate());
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.01,
          ),
          child: Container(
            height: seedetails ? size.height * 0.95 : size.height * 0.082,
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
                    padding: EdgeInsets.only(top: size.height * 0.015),
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
                              vertical: size.height * 0.014),
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
                          child: SizedBox(
                            width: 35,
                            child: Text(
                              createdDate,
                              style: const TextStyle(
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
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.65,
                      ),
                      child: const Text(
                        'Leave',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  if (seedetails)
                    Row(
                        children: List.generate(
                            widget.snapped['Leavedate'].length, (index) {
                      final date =
                          widget.snapped['Leavedate'][index] as Timestamp;
                      final formattedate =
                          DateFormat.MMMd().format(date.toDate());
                      return Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.06,
                        ),
                        child: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.18,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffffffff),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              formattedate,
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    widget.snapped['takeleave']
                        ? SizedBox(
                            height: size.height * 0.00,
                          )
                        : Padding(
                            padding: EdgeInsets.only(
                              right: size.width * 0.56,
                            ),
                            child: const Text(
                              'Alternate',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                  if (seedetails)
                    widget.snapped['takeleave']
                        ? SizedBox(
                            height: size.height * 0.0,
                          )
                        : SizedBox(
                            height: size.height * 0.01,
                          ),
                  if (seedetails)
                    widget.snapped['takeleave']
                        ? Text('')
                        : Row(
                            children: List.generate(
                                widget.snapped['Alternatedate'].length,
                                (index) {
                            final date = widget.snapped['Alternatedate'][index]
                                as Timestamp;
                            final formattedate =
                                DateFormat.MMMd().format(date.toDate());
                            return Padding(
                              padding: EdgeInsets.only(
                                left: size.width * 0.06,
                              ),
                              child: Container(
                                height: size.height * 0.06,
                                width: size.width * 0.18,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffffffff),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    formattedate,
                                    style: TextStyle(
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })

                            // SizedBox(
                            //   width: size.width * 0.01,
                            // ),

                            ),
                  if (seedetails)
                    widget.snapped['takeleave']
                        ? SizedBox(
                            height: 0.0,
                          )
                        : SizedBox(
                            height: size.height * 0.03,
                          ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.52,
                      ),
                      child: const Text(
                        'Leave option',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                      ),
                      child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.74,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xffffffff),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: widget.snapped['takeleave']
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Take Leave',
                                  style: TextStyle(color: Color(0xffffffff)),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Alternate Date',
                                  style: TextStyle(color: Color(0xffffffff)),
                                ),
                              ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.65,
                      ),
                      child: const Text(
                        'Role',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                      ),
                      child: Container(
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
                            widget.snapped['role'],
                            style: TextStyle(color: Color(0xffffffff)),
                          ),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.only(
                        right: size.width * 0.60,
                      ),
                      child: const Text(
                        'Reason',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                      ),
                      child: Container(
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
                            widget.snapped['reason'],
                            style: TextStyle(color: Color(0xffffffff)),
                          ),
                        ),
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  if (seedetails)
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xffff7575),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              // textStyle: const TextStyle(
                              //   fontSize: 16,
                              //   fontWeight: FontWeight.w500,
                              // ),
                              fixedSize:
                                  Size(size.width * 0.22, size.height * 0.05),

                              elevation: 8,
                            ),
                            onPressed: () async {
                              setState(() {
                                reject = true;
                              });
                              await FirebaseFirestore.instance
                                  .collection('Leave details')
                                  .doc(widget.snapped['id'])
                                  .update({'isCancelled': reject});
                            },
                            child: const Text(
                              'Reject',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          ),
                          if (seedetails)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xff03710e),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                // textStyle: const TextStyle(
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.w500,
                                // ),
                                fixedSize:
                                    Size(size.width * 0.22, size.height * 0.05),

                                elevation: 8,
                              ),
                              onPressed: () async {
                                if (widget.snapped['approval'][0] ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid &&
                                    widget.snapped['approval'][1] ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                  setState(() {
                                    approval = true;
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('Leave details')
                                      .doc(widget.snapped['id'])
                                      .update({'quickapproval': approval});
                                }
                              },
                              child: const Text(
                                'Approval',
                                style: TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ),
                        ],
                      ),
                    ),
                  if (seedetails)
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                  if (seedetails)
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xff5200ff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          // textStyle: const TextStyle(
                          //   fontSize: 16,
                          //   fontWeight: FontWeight.w500,
                          // ),
                          fixedSize:
                              Size(size.width * 0.28, size.height * 0.05),

                          elevation: 8,
                        ),
                        onPressed: () async {
                          if ('OebtkLEqFMNVE6O4AivOJG4ixKq2' ==
                              FirebaseAuth.instance.currentUser!.uid) {
                            setState(() {
                              approval = true;
                            });
                            await FirebaseFirestore.instance
                                .collection('Leave details')
                                .doc(widget.snapped['id'])
                                .update({'quickapproval': approval});
                          }
                        },
                        child: const Text(
                          'Qucik approval',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
