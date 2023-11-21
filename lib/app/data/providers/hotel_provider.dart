import 'package:get/get.dart';

import '../models/hotel_model.dart';

class HotelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Hotel.fromJson(map);
      if (map is List) return map.map((item) => Hotel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Hotel?> getHotel(int id) async {
    final response = await get('hotel/$id');
    return response.body;
  }

  Future<Response<Hotel>> postHotel(Hotel hotel) async =>
      await post('hotel', hotel);
  Future<Response> deleteHotel(int id) async => await delete('hotel/$id');
}
