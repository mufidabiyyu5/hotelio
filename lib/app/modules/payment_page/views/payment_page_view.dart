import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/components/button_custom.dart';
import 'package:hotelio/app/config/app_assets.dart';
import 'package:hotelio/app/config/app_colors.dart';
import 'package:hotelio/app/config/app_format.dart';
import 'package:hotelio/app/data/models/booking_model.dart';
import 'package:hotelio/app/data/models/hotel_model.dart';
import 'package:hotelio/app/modules/home/controllers/user_controller.dart';
import 'package:hotelio/app/routes/app_pages.dart';
import 'package:hotelio/app/sources/booking_source.dart';
import 'package:intl/intl.dart';

import '../controllers/payment_page_controller.dart';

class PaymentPageView extends GetView<PaymentPageController> {
  PaymentPageView({Key? key}) : super(key: key);

  Hotel hotel = Get.arguments as Hotel;
  final user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Checkout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            hotelContainer(),
            const SizedBox(height: 24),
            roomDetails(),
            const SizedBox(height: 24),
            paymentMethod(),
            const SizedBox(height: 24),
            ButtonCustom(
              label: "Proceed to Payment",
              onPressed: () {
                BookingSource.addBooking(
                  user.userData.id.toString(),
                  Booking(
                    id: '',
                    idHotel: hotel.id,
                    cover: hotel.cover,
                    name: hotel.name,
                    location: hotel.location,
                    date: DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    guest: 2,
                    breakfast: 'Included',
                    checkInTime: '14.00 WIB',
                    night: 1,
                    serviceFee: 25,
                    activities: 30,
                    totalPayment: (hotel.price! * 2) + 25 + 30,
                    status: "PAID",
                    isDone: false,
                  ),
                );
                Get.offNamed(Routes.SUCCESS_PAGE, arguments: hotel);
              },
              isExpand: true,
            ),
          ],
        ),
      ),
    );
  }

  Container paymentMethod() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment Method",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.iconMasterCard,
                  height: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.userData.name.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Balance ${AppFormat.currency(80000)}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.check_circle,
                  size: 24,
                  color: AppColor.secondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container roomDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Room Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          rowDetails(
            "Date",
            AppFormat.date(
              DateTime.now().toIso8601String(),
            ),
          ),
          const SizedBox(height: 8),
          rowDetails("Guest", "2 Guests"),
          const SizedBox(height: 8),
          rowDetails("Breakfast", "Included"),
          const SizedBox(height: 8),
          rowDetails("Check-in Time", "14.00 WIB"),
          const SizedBox(height: 8),
          rowDetails(
            "1 night",
            AppFormat.currency(
              hotel.price!.toDouble(),
            ),
          ),
          const SizedBox(height: 8),
          rowDetails("Service Fee", AppFormat.currency(25)),
          const SizedBox(height: 8),
          rowDetails("Activities", AppFormat.currency(30)),
          const SizedBox(height: 8),
          rowDetails(
            "Total",
            AppFormat.currency(hotel.price!.toDouble() + 25 + 30),
          ),
        ],
      ),
    );
  }

  Row rowDetails(String title, String data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Container hotelContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              hotel.cover.toString(),
              width: 90,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hotel.location.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
