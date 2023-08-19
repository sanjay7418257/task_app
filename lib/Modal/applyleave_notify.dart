import 'package:cloud_firestore/cloud_firestore.dart';

enum NotifyAccess {
  isFeedback,
  isLeaveStatus,
  taskCreateStatus,
  appliedStatus,
}

// const access = {
//   NotifyAccess.isAnnouncement: false,
//   NotifyAccess.appliedStatus: false,
//   NotifyAccess.taskCreateStatus: false,
//   NotifyAccess.isLeaveStatus: false
// };

class ApplyLeaveNotify {
  final String name;
  List leaveDate;
  List alternateDate;
  String recieverUid;
  String senderUid;
  String image;
  String id;
  String notifyBody;
  final String notifyStatus;
  DateTime createdDate;
  ApplyLeaveNotify({
    required this.name,
    required this.leaveDate,
    required this.alternateDate,
    required this.recieverUid,
    required this.senderUid,
    required this.image,
    required this.id,
    required this.notifyStatus,
    required this.notifyBody,
    required this.createdDate,
  });
  Map<String, dynamic> tojson() => {
        'name': name,
        'leaveDate': leaveDate,
        'alternateDate': alternateDate,
        'recieverUid': recieverUid,
        'senderUid': senderUid,
        'image': image,
        'id': id,
        'notifyStatus': notifyStatus,
        'notifyBody': notifyBody,
        'createdDate': createdDate,
      };

  static ApplyLeaveNotify fromsnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return ApplyLeaveNotify(
      name: snapshot['name'],
      leaveDate: snapshot['leaveDate'],
      alternateDate: snapshot['alternateDate'],
      id: snapshot['id'],
      image: snapshot['image'],
      recieverUid: snapshot['recieverUid'],
      senderUid: snapshot['senderUid'],
      notifyStatus: snapshot['notifyStatus'],
      notifyBody: snapshot['notifyBody'],
      createdDate: snapshot['createdDate'],
    );
  }
}
