import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference myCollection =
    FirebaseFirestore.instance.collection('task create');
void fetchDataFromFirestore() {
  myCollection.get().then((QuerySnapshot querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      querySnapshot.docs.forEach((doc) {
        var taskname = doc['taskname'];
      });
    }
  });
}
