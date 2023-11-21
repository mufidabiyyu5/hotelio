import 'package:get/get.dart';
import 'package:hotelio/app/data/models/booking_model.dart';

class DetailPageController extends GetxController {
  //TODO: Implement DetailPageController
  final _booking = initBooking.obs;
  Booking get bookedData => _booking.value;
  set bookedData(Booking n) => _booking.value = n;
}
