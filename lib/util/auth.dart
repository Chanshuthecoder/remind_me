import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<String> signUp(String uEmail, String uPassword) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: uEmail, password: uPassword);
    return Future.value(userCredential.user.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
  return Future.value("error");
}

Future<String> logIn(String email, String password) async {
  try {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return Future.value(userCredential.user.uid);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else {
      print(e);
    }
  }
  return Future.value("error");
}

Future<void> logOut() async {
  await auth.signOut();
}
