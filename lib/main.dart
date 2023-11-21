import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/config/app_colors.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('en_US');

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.bgColor,
        primaryColor: AppColor.primaryColor,
        colorScheme: const ColorScheme.light(
          primary: AppColor.primaryColor,
          secondary: AppColor.secondaryColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
