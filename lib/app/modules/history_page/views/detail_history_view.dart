import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/data/models/booking_model.dart';

import '../../../config/app_format.dart';

class DetailHistoryView extends GetView {
  DetailHistoryView({Key? key}) : super(key: key);
  Booking booking = Get.arguments as Booking;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Booking Details',
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
            bookingContainer(),
            const SizedBox(height: 24),
            roomDetails(),
          ],
        ),
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
            AppFormat.date(booking.date!),
          ),
          const SizedBox(height: 8),
          rowDetails("Guest", "${booking.guest} Guests"),
          const SizedBox(height: 8),
          rowDetails("Breakfast", booking.breakfast!),
          const SizedBox(height: 8),
          rowDetails("Check-in Time", booking.checkInTime!),
          const SizedBox(height: 8),
          rowDetails(
            "1 night",
            AppFormat.currency(
              booking.night!.toDouble(),
            ),
          ),
          const SizedBox(height: 8),
          rowDetails(
            "Service Fee",
            AppFormat.currency(booking.serviceFee!.toDouble()),
          ),
          const SizedBox(height: 8),
          rowDetails(
            "Activities",
            AppFormat.currency(booking.activities!.toDouble()),
          ),
          const SizedBox(height: 8),
          rowDetails(
            "Total",
            AppFormat.currency(booking.totalPayment!.toDouble()),
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

  Container bookingContainer() {
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
              booking.cover.toString(),
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
                  booking.name.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  booking.location.toString(),
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
