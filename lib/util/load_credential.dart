import 'package:remind_me/util/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> loadCredential() async {
  User userData = User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var user = (prefs.getStringList('user') ?? null);
  if (user != null) {
    userData.uId = user[0];
    userData.uType = user[1];
    userData.uName = user[2];
  }
  return Future.value(userData);
}
