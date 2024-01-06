import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/components/button_custom.dart';
import 'package:hotelio/app/data/models/hotel_model.dart';
import 'package:hotelio/app/modules/home/controllers/home_controller.dart';
import 'package:hotelio/app/routes/app_pages.dart';

class SuccessPageView extends GetView {
  SuccessPageView({Key? key}) : super(key: key);

  Hotel hotel = Get.arguments as Hotel;
  HomeController home = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(
                    hotel.cover.toString(),
                    width: 200,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              const Text(
                "Payment Success",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                "Enjoy your a whole new experience\nin this beautiful world",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              ButtonCustom(
                label: "View My Booking",
                onPressed: () {
                  home.i.value = 1;
                  Get.offNamed(Routes.HOME);
                },
                isExpand: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
