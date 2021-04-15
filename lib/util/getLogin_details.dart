import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getLoginCredentials(String userId) async {
  final users = await FirebaseFirestore.instance
      .collection('/users')
      .doc(userId)
      .get()
      .then((value) {
    return value.data();
  });
  Map<String, dynamic> data = users;
  return Future.value(data);
}
