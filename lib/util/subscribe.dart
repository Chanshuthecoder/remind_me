import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remind_me/util/load_credential.dart';

void subscribe(String clubName) {
  loadCredential().then((x) {
    String uid = x.uId;
    final db = FirebaseFirestore.instance.collection('/users/$uid/club');
    db.add({'name': clubName});
  });
}
