class Booking {
  String? id;
  String? idHotel;
  String? cover;
  String? name;
  String? location;
  String? date;
  int? guest;
  String? breakfast;
  String? checkInTime;
  int? night;
  int? serviceFee;
  int? activities;
  int? totalPayment;
  String? status;
  bool? isDone;

  Booking(
      {this.id,
      this.idHotel,
      this.cover,
      this.name,
      this.location,
      this.date,
      this.guest,
      this.breakfast,
      this.checkInTime,
      this.night,
      this.serviceFee,
      this.activities,
      this.totalPayment,
      this.status,
      this.isDone});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idHotel = json['id_hotel'];
    cover = json['cover'];
    name = json['name'];
    location = json['location'];
    date = json['date'];
    guest = json['guest'];
    breakfast = json['breakfast'];
    checkInTime = json['check_in_time'];
    night = json['night'];
    serviceFee = json['service_fee'];
    activities = json['activities'];
    totalPayment = json['total_payment'];
    status = json['status'];
    isDone = json['is_done'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['id_hotel'] = idHotel;
    data['cover'] = cover;
    data['name'] = name;
    data['location'] = location;
    data['date'] = date;
    data['guest'] = guest;
    data['breakfast'] = breakfast;
    data['check_in_time'] = checkInTime;
    data['night'] = night;
    data['service_fee'] = serviceFee;
    data['activities'] = activities;
    data['total_payment'] = totalPayment;
    data['status'] = status;
    data['is_done'] = isDone;
    return data;
  }
}

Booking get initBooking => Booking(
      id: '',
      idHotel: '',
      cover: '',
      name: '',
      location: '',
      date: '',
      guest: 0,
      breakfast: '',
      checkInTime: '',
      night: 0,
      serviceFee: 0,
      activities: 0,
      totalPayment: 0,
      status: '',
      isDone: false,
    );
