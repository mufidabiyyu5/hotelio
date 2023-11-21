import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/components/button_custom.dart';
import 'package:hotelio/app/config/app_colors.dart';
import 'package:hotelio/app/config/app_format.dart';
import 'package:hotelio/app/data/models/booking_model.dart';
import 'package:hotelio/app/data/models/hotel_model.dart';
import 'package:hotelio/app/modules/home/controllers/user_controller.dart';
import 'package:hotelio/app/sources/booking_source.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  DetailPageView({super.key});

  Hotel hotel = Get.arguments['hotel'] as Hotel;
  final user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    BookingSource.isBooked(user.userData.id.toString(), hotel.id.toString())
        .then((bookingValue) {
      controller.bookedData = bookingValue ?? initBooking;
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotel Details',
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
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView(
          children: [
            const SizedBox(height: 24),
            images(hotel),
            const SizedBox(height: 16),
            title(hotel),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                hotel.description!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Facilities",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            facilitiesItem(hotel),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Activities",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            listActivities(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.bookedData.id == '') {
          return bookingNow(hotel, context);
        }
        return viewReceipt();
      }),
    );
  }

  Wrap viewReceipt() {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  "You booked this.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    side: BorderSide.none,
                  ),
                  shadowColor: AppColor.secondaryColor,
                  elevation: 8,
                ),
                onPressed: () {},
                child: const Text(
                  "View Receipt",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Wrap bookingNow(Hotel hotel, BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppFormat.currency(hotel.price!.toDouble()),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColor.secondaryColor,
                      ),
                    ),
                    const Text(
                      "per night",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              ButtonCustom(
                label: "Booking Now",
                onPressed: () {},
                isExpand: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox listActivities() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: hotel.activities!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 24 : 8,
              right: index == hotel.activities!.length ? 24 : 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    hotel.activities![index].image.toString(),
                    width: 90,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hotel.activities![index].name.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  GridView facilitiesItem(Hotel hotel) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: hotel.facilities!.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          // padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                hotel.facilities![index].icon.toString(),
                height: 24,
                width: 24,
              ),
              const SizedBox(height: 4),
              Text(
                hotel.facilities![index].name.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding title(Hotel hotel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hotel.location!,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.star_rate_rounded,
            color: AppColor.starActive,
            size: 24,
          ),
          const SizedBox(width: 4),
          Text(
            hotel.rate.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox images(Hotel hotel) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: hotel.images!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 24 : 8,
              right: index == hotel.images!.length - 1 ? 24 : 8,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                hotel.images![index],
                height: 20,
                width: 280,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
