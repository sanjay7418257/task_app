import 'package:cloud_firestore/cloud_firestore.dart';

class authenticate {
  String name;
  String email;
  String image;
  String uuid;

  authenticate({
    required this.name,
    required this.email,
    required this.image,
    required this.uuid,
  });
  Map<String, dynamic> tojson() => {
        "name": name,
        "email": email,
        "image": image,
        'uuid': uuid,
      };
  static authenticate fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return authenticate(
      name: snapshot['name'],
      email: snapshot['email'],
      image: snapshot['image'],
      uuid: snapshot['uuid'],
    );
  }
}
