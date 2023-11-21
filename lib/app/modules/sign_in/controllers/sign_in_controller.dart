import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotelio/app/routes/app_pages.dart';
import 'package:hotelio/app/sources/user_source.dart';

class SignInController extends GetxController {
  //TODO: Implement SignInController

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final formKey = GlobalKey<FormState>();

  login(BuildContext context) {
    if (formKey.currentState!.validate()) {
      UserSource.signIn(email.text, pass.text).then((response) {
        if (response['success']) {
          DInfo.dialogSuccess(context, response['message']);
          DInfo.closeDialog(context, actionAfterClose: () {
            Get.offNamed(Routes.HOME);
          });
        } else {
          DInfo.toastError(response['message']);
        }
      });
    }
  }
}
