import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelio/app/config/session.dart';

import '../data/models/user_model.dart';

class UserSource {
  static Future<Map<String, dynamic>> signIn(
    String email,
    String password,
  ) async {
    Map<String, dynamic> response = {};
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      response['success'] = true;
      response['message'] = 'Sign In Success';
      String uid = credential.user!.uid;
      Users user = await getWhereId(uid);
      Session.saveUser(user);
    } on FirebaseAuthException catch (e) {
      response['success'] = false;
      if (e.code == 'user-not-found') {
        response['message'] = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        response['message'] = 'Wrong password provided for that user.';
      } else {
        response['message'] = 'Sign In Fail';
      }
    }
    return response;
  }

  static Future<Users> getWhereId(String id) async {
    DocumentReference<Map<String, dynamic>> ref =
        FirebaseFirestore.instance.collection('User').doc(id);
    DocumentSnapshot<Map<String, dynamic>> doc = await ref.get();
    return Users.fromJson(doc.data()!);
  }
}
