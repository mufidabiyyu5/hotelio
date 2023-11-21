import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/config/app_assets.dart';
import 'package:hotelio/app/routes/app_pages.dart';
import '../../../components/button_custom.dart';

class IntroView extends GetView {
  const IntroView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('IntroView'),
        //   centerTitle: true,
        // ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.bgIntro,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Great Life \nStarts Here',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'More than just a hotel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  ButtonCustom(
                    label: 'Get Started',
                    onPressed: () => Get.offNamed(Routes.SIGN_IN),
                    isExpand: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
