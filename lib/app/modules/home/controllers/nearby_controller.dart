import 'package:get/get.dart';
import 'package:hotelio/app/data/models/hotel_model.dart';
import 'package:hotelio/app/sources/hotel_source.dart';

class NearbyController extends GetxController {
  final _category = "All Place".obs;
  String get category => _category.value;
  setCategory(String n) {
    _category.value = n;
    update();
  }

  List<String> categories = [
    "All Place",
    "Industrial",
    "Village",
  ];

  final _listHotel = <Hotel>[].obs;
  List<Hotel> get listHotel => _listHotel.value;
  getListHotel() async {
    _listHotel.value = await HotelSource.getHotel();
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getListHotel();
    super.onInit();
  }
}
