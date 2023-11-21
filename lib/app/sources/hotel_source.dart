import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotelio/app/data/models/hotel_model.dart';

class HotelSource {
  static Future<List<Hotel>> getHotel() async {
    var result = await FirebaseFirestore.instance.collection('Hotels').get();
    return result.docs.map((e) => Hotel.fromJson(e.data())).toList();
  }
}
