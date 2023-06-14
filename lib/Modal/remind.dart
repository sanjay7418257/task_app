import 'package:cloud_firestore/cloud_firestore.dart';

class reminder {
  String remind;
  DateTime selectedDate;
  DateTime createdDate;
  bool isCompleted;
  String id;
  String uuid;

  reminder({
    required this.remind,
    required this.selectedDate,
    required this.createdDate,
    required this.isCompleted,
    required this.id,
    required this.uuid,
  });

  Map<String, dynamic> tojson() => {
        'remind': remind,
        'selectedDate': selectedDate,
        'createdDate': createdDate,
        'isCompleted': isCompleted,
        'id': id,
        'uuid': uuid,
      };

  static reminder fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return reminder(
      remind: snapshot['remind'],
      selectedDate: snapshot['selectedDate'],
      createdDate: snapshot['createdDate'],
      isCompleted: snapshot['isCompleted'],
      id: snapshot['id'],
      uuid: snapshot['uuid'],
    );
  }
}
