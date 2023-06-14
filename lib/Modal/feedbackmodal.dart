import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class feedbackmodal {
  String colleaguesname;
  String feedback;
  DateTime createDate;
  bool one;
  bool two;
  bool three;
  bool four;
  bool five;
  String id;
  String uuid;
  String signaturepad;

  feedbackmodal({
    required this.colleaguesname,
    required this.feedback,
    required this.createDate,
    required this.one,
    required this.two,
    required this.three,
    required this.four,
    required this.five,
    required this.id,
    required this.uuid,
    required this.signaturepad,
  });

  Map<String, dynamic> tojson() => {
        'colleaguesname': colleaguesname,
        'feedback': feedback,
        'createDate': createDate,
        'one': one,
        'two': two,
        'three': three,
        'four': four,
        'five': five,
        'id': id,
        'uuid': uuid,
        'signaturedpad': signaturepad,
      };

  static feedbackmodal fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return feedbackmodal(
      colleaguesname: snapshot['colleaguesname'],
      feedback: snapshot['feedback'],
      createDate: snapshot['createDate'],
      one: snapshot['one'],
      two: snapshot['two'],
      three: snapshot['three'],
      four: snapshot['four'],
      five: snapshot['five'],
      id: snapshot['id'],
      uuid: snapshot['uuid'],
      signaturepad: snapshot['signaturepad'],
    );
  }
}
