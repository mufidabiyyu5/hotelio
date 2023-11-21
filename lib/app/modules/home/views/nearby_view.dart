import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:hotelio/app/config/app_assets.dart';
import 'package:hotelio/app/config/app_colors.dart';
import 'package:hotelio/app/config/app_format.dart';
import 'package:hotelio/app/data/models/hotel_model.dart';
import 'package:hotelio/app/modules/home/controllers/nearby_controller.dart';
import 'package:hotelio/app/routes/app_pages.dart';

class NearbyView extends GetView {
  NearbyController cNearby = Get.put(NearbyController());

  NearbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        header(context),
        const SizedBox(height: 32),
        searchBar(),
        const SizedBox(height: 32),
        chipsCategories(),
        const SizedBox(height: 32),
        hotels(),
      ],
    );
  }

  GetBuilder<NearbyController> hotels() {
    return GetBuilder<NearbyController>(
      builder: (_) {
        List<Hotel> list = cNearby.category == "All Place"
            ? cNearby.listHotel
            : cNearby.listHotel
                .where((e) => e.category == cNearby.category)
                .toList();
        if (list.isEmpty) {
          return const Center(
            child: Text("Tidak ada hotel"),
          );
        }
        return ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Hotel hotel = list[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(
                    Routes.DETAIL_PAGE,
                    arguments: {
                      'hotel': hotel,
                    },
                  );
                  // Navigator.pushNamed(
                  //   context,
                  //   Routes.DETAIL_PAGE,
                  //   arguments: hotel,
                  // );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          "${hotel.cover}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${hotel.name}",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Start from ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      AppFormat.currency(
                                          hotel.price!.toDouble()),
                                      style: const TextStyle(
                                        color: AppColor.secondaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Text(
                                      "/night",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: hotel.rate!.toDouble(),
                            itemSize: 20,
                            allowHalfRating: true,
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star_rate_rounded,
                              color: AppColor.starActive,
                            ),
                            unratedColor: AppColor.starInactive,
                            onRatingUpdate: (rating) {},
                            ignoreGestures: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  GetBuilder<NearbyController> chipsCategories() {
    return GetBuilder<NearbyController>(
      builder: (_) {
        return SizedBox(
          height: 50,
          child: ListView.builder(
            itemCount: cNearby.categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String category = cNearby.categories[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 24 : 8,
                  right: index == cNearby.categories.length - 1 ? 24 : 8,
                ),
                child: Material(
                  borderRadius: BorderRadius.circular(24),
                  color: category == cNearby.category
                      ? AppColor.primaryColor
                      : Colors.white,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () => cNearby.setCategory(category),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        cNearby.categories[index],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: category == cNearby.category
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Container searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 50,
      child: Stack(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: "Search by name or city",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: AppColor.secondaryColor,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(50),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Center(
                    child: ImageIcon(
                      AssetImage(AppAssets.iconSearch),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(360),
            child: Image.asset(
              AppAssets.profile,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Near Me",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "189 hotels",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
