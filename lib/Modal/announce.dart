import 'package:cloud_firestore/cloud_firestore.dart';

class announce {
  String announcement;
  String uuid;
  DateTime createdDate;
  String id;
  announce({
    required this.announcement,
    required this.uuid,
    required this.createdDate,
    required this.id,
  });

  Map<String, dynamic> tojson() => {
        'announcement': announcement,
        'uuid': uuid,
        'createdDate': createdDate,
        'id': id,
      };

  static announce fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return announce(
      announcement: snapshot['announcement'],
      uuid: snapshot['uuid'],
      createdDate: snapshot['createdDate'],
      id: snapshot['id'],
    );
  }
}
