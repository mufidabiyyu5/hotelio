import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/components/button_custom.dart';
import 'package:hotelio/app/config/app_assets.dart';
import 'package:hotelio/app/config/app_colors.dart';
import 'package:hotelio/app/modules/history_page/views/history_page_view.dart';
import 'package:hotelio/app/modules/home/views/nearby_view.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  List<Map> listNav = [
    {"icon": AppAssets.iconNearby, "name": "Nearby"},
    {"icon": AppAssets.iconHistory, "name": "History"},
    {"icon": AppAssets.iconPayment, "name": "Payment"},
    {"icon": AppAssets.iconReward, "name": "Reward"},
  ];

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () {
            if (controller.i.value == 0) {
              return NearbyView();
            } else if (controller.i.value == 1) {
              return HistoryPageView();
            } else if (controller.i.value == 2) {
              return Center(
                child: Text("PaymentPage"),
              );
            } else {
              return Center(
                child: ButtonCustom(
                  label: "Sign Out",
                  onPressed: () => controller.signOut(),
                  isExpand: false,
                ),
              );
            }
          },
        ),
        bottomNavigationBar: Obx(
          () => ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: controller.i.value,
                  onTap: (value) => controller.i.value = value,
                  items: listNav.map(
                    (e) {
                      return BottomNavigationBarItem(
                        icon: ImageIcon(AssetImage(e['icon'])),
                        label: e['name'],
                      );
                    },
                  ).toList(),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  selectedFontSize: 12,
                  unselectedItemColor: Colors.grey,
                  unselectedFontSize: 12,
                  unselectedIconTheme: IconThemeData(
                    color: Colors.grey,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  selectedIconTheme: IconThemeData(
                    color: AppColor.primaryColor,
                  ),
                  selectedItemColor: Colors.black,
                  selectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
