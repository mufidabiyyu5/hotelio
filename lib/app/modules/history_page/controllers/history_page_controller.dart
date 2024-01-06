import 'package:get/get.dart';
import 'package:hotelio/app/data/models/booking_model.dart';
import 'package:hotelio/app/modules/home/controllers/user_controller.dart';
import 'package:hotelio/app/sources/booking_source.dart';

class HistoryPageController extends GetxController {
  //TODO: Implement HistoryPageController

  final _listHistory = <Booking>[].obs;
  List<Booking> get listHistory => _listHistory.value;
  getListHistory(String id) async {
    _listHistory.value = await BookingSource.getHistory(id);
    update();
  }
}
