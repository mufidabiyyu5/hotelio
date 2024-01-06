import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:hotelio/app/config/app_colors.dart';
import 'package:hotelio/app/config/app_format.dart';
import 'package:hotelio/app/data/models/booking_model.dart';
import 'package:hotelio/app/modules/home/controllers/user_controller.dart';
import 'package:hotelio/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

import '../../../config/app_assets.dart';
import '../controllers/history_page_controller.dart';

class HistoryPageView extends StatefulWidget {
  HistoryPageView({Key? key}) : super(key: key);

  @override
  State<HistoryPageView> createState() => _HistoryPageViewState();
}

class _HistoryPageViewState extends State<HistoryPageView> {
  final history = Get.put(HistoryPageController());
  final user = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    history.getListHistory(user.userData.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        header(context),
        const SizedBox(height: 24),
        GetBuilder<HistoryPageController>(
          builder: (_) {
            return GroupedListView<Booking, String>(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              elements: _.listHistory,
              groupBy: (element) => element.date!,
              groupSeparatorBuilder: (String groupByValue) {
                String date = DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                        groupByValue
                    ? 'Today New'
                    : AppFormat.dateMonth(groupByValue);
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
              itemBuilder: (context, element) {
                return itemBooking(context, element);
              },
              itemComparator: (item1, item2) =>
                  item1.date!.compareTo(item2.date!), // optional
              order: GroupedListOrder.DESC, // optional
            );
          },
        ),
      ],
    );
  }

  Widget itemBooking(BuildContext context, Booking booking) {
    Color statusColor;

    if (booking.status == "PAID") {
      statusColor = AppColor.secondaryColor;
    } else if (booking.status == "UNPAID") {
      statusColor = Colors.orange;
    } else if (booking.status == "CANCELED") {
      statusColor = Colors.red.shade400;
    } else {
      statusColor = AppColor.primaryColor;
    }

    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.HISTORY_DETAIL_PAGE,
          arguments: booking,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 8),
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
                    booking.date.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                booking.status.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding header(BuildContext context) {
    String text =
        history.listHistory.length > 1 ? "transactions" : "transaction";
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
              const Text(
                "My Booking",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Obx(
                () => Text(
                  "${history.listHistory.length} $text",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
