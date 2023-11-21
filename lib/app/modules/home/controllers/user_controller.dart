import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class UserController extends GetxController {
  final data = Users().obs;
  Users get userData => data.value;
  setData(Users n) => data.value = n;
}
