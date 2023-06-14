import 'package:cloud_firestore/cloud_firestore.dart';

class leavemodal {
  String reason;
  List<DateTime> Alternatedate;
  List<DateTime> Leavedate;
  String role;
  DateTime createdDate;
  bool takeleave;
  String id;
  List approval;
  bool isCancelled;
  String uuid;
  bool quickapproval;

  leavemodal({
    required this.reason,
    required this.Alternatedate,
    required this.Leavedate,
    required this.role,
    required this.createdDate,
    required this.takeleave,
    required this.id,
    required this.approval,
    required this.isCancelled,
    required this.uuid,
    required this.quickapproval,
  });

  Map<String, dynamic> tojson() => {
        'reason': reason,
        'Alternatedate': Alternatedate,
        'Leavedate': Leavedate,
        'role': role,
        'createdDate': createdDate,
        'takeleave': takeleave,
        'id': id,
        'approval': approval,
        'isCancelled': isCancelled,
        'uuid': uuid,
        'quickapproval': quickapproval,
      };
  static leavemodal fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return leavemodal(
      reason: snapshot['reason'],
      Alternatedate: snapshot['Alternatedate'],
      Leavedate: snapshot['Leavedate'],
      role: snapshot['role'],
      createdDate: snapshot['createdDate'],
      takeleave: snapshot['takeleave'],
      id: snapshot['id'],
      approval: snapshot['approval'],
      isCancelled: snapshot['isCancelled'],
      uuid: snapshot['uuid'],
      quickapproval: snapshot['quickapproval'],
    );
  }
}
