import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hotelio/app/routes/app_pages.dart';
import '../../../config/session.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

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
