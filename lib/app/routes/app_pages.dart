import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../config/session.dart';
import '../data/models/user_model.dart';
import '../modules/detail_page/bindings/detail_page_binding.dart';
import '../modules/detail_page/views/detail_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/intro_view.dart';
import '../modules/payment_page/bindings/payment_page_binding.dart';
import '../modules/payment_page/views/payment_page_view.dart';
import '../modules/payment_page/views/success_page_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START;

  static final routes = [
    GetPage(
      name: _Paths.START,
      page: () => FutureBuilder(
        future: Session.getUser(),
        builder: (context, AsyncSnapshot<Users> snapshot) {
          if (snapshot.data == null || snapshot.data!.id == null) {
            return const IntroView();
          } else {
            return HomeView();
          }
        },
      ),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRO,
      page: () => IntroView(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE,
      page: () => DetailPageView(),
      binding: DetailPageBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_PAGE,
      page: () => PaymentPageView(),
      binding: PaymentPageBinding(),
    ),
    GetPage(
      name: _Paths.SUCCESS_PAGE,
      page: () => SuccessPageView(),
    ),
  ];
}
