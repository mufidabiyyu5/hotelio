import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hotelio/app/routes/app_pages.dart';
import '../../../config/session.dart';
import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final _data = Users().obs;
  Users get Data => _data.value;
  setData(Users n) => _data.value = n;

  final i = 0.obs;
  get index => i.value;
  setIndex(int n) => i.value = n;

  void signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Session.clearUser();
      Get.offNamed(Routes.SIGN_IN);
    } catch (e) {}
  }
}
