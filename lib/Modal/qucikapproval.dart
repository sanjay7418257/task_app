import 'package:cloud_firestore/cloud_firestore.dart';

class quickapproval {
  DateTime createdDate;
  bool approval;
  String uuid;
  String id;

  quickapproval({
    required this.createdDate,
    required this.approval,
    required this.uuid,
    required this.id,
  });
  Map<String, dynamic> tojson() => {
        'createdDate': createdDate,
        'approval': approval,
        'uuid': uuid,
        'id': id,
      };

  static quickapproval fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return quickapproval(
      createdDate: snapshot['createdDate'],
      approval: snapshot['approval'],
      uuid: snapshot['uuid'],
      id: snapshot['id'],
    );
  }
}
