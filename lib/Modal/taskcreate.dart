import 'package:cloud_firestore/cloud_firestore.dart';

var growableList = List.from([], growable: true);

class creating {
  DateTime selectedDay;
  String taskname;
  String id;
  List addpeople;
  DateTime createdDate;
  String extranotes;
  int percent;
  List name;
  creating({
    required this.selectedDay,
    required this.taskname,
    required this.id,
    required this.addpeople,
    required this.createdDate,
    required this.extranotes,
    required this.percent,
    required this.name,
  });

  Map<String, dynamic> tojson() => {
        'taskname': taskname,
        'id': id,
        'selectedDay': selectedDay,
        'addpeople': addpeople,
        'createdDate': createdDate,
        'Extranotes': extranotes,
        'percent': percent,
        'name': name,
      };
  static creating fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return creating(
      selectedDay: snapshot['selectedDay'],
      taskname: snapshot['taskname'],
      id: snapshot['id'],
      addpeople: snapshot['addpeople'],
      createdDate: snapshot['createdDate'],
      extranotes: snapshot['Extranotes'],
      percent: snapshot['percent'],
      name: snapshot['name'],
    );
  }
}
