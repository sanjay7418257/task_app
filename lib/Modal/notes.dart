import 'package:cloud_firestore/cloud_firestore.dart';

class note {
  String notes;
  DateTime createdDate;
  String uuid;
  String id;

  note({
    required this.notes,
    required this.createdDate,
    required this.uuid,
    required this.id,
  });

  Map<String, dynamic> tojson() => {
        'notes': notes,
        'createdDate': createdDate,
        'uuid': uuid,
        'id': id,
      };
  static note fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return note(
      notes: snapshot['notes'],
      createdDate: snapshot['createdDate'],
      uuid: snapshot['uuid'],
      id: snapshot['id'],
    );
  }
}
