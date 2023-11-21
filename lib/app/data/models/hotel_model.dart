class Hotel {
  String? id;
  String? name;
  String? description;
  String? cover;
  int? price;
  double? rate;
  List<String>? images;
  String? location;
  String? category;
  List<Activities>? activities;
  List<Facilities>? facilities;

  Hotel(
      {this.id,
      this.name,
      this.description,
      this.cover,
      this.price,
      this.rate,
      this.images,
      this.location,
      this.category,
      this.activities,
      this.facilities});

  Hotel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    cover = json['cover'];
    price = json['price'];
    rate = json['rate'];
    images = json['images'].cast<String>();
    location = json['location'];
    category = json['category'];
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities?.add(Activities.fromJson(v));
      });
    }
    if (json['facilities'] != null) {
      facilities = <Facilities>[];
      json['facilities'].forEach((v) {
        facilities?.add(Facilities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['cover'] = cover;
    data['price'] = price;
    data['rate'] = rate;
    data['images'] = images;
    data['location'] = location;
    data['category'] = category;
    if (activities != null) {
      data['activities'] = activities?.map((v) => v.toJson()).toList();
    }
    if (facilities != null) {
      data['facilities'] = facilities?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  String? image;
  String? name;

  Activities({this.image, this.name});

  Activities.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    return data;
  }
}

class Facilities {
  String? icon;
  String? name;

  Facilities({this.icon, this.name});

  Facilities.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['icon'] = icon;
    data['name'] = name;
    return data;
  }
}
