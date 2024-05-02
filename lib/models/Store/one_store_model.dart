class OneStoreModel {
  OneStoreModel({
    this.id,
    this.enName,
    this.arName,
    this.enAddress,
    this.arAddress,
    this.enDesc,
    this.arDesc,
    this.phone,
    this.phone2,
    this.phone3,
    this.phone4,
    this.phone5,
    this.whatsapp,
    this.facebook,
    this.youtube,
    this.website,
    this.location,
    required this.rating,
    this.imgs,
  });
  String? id;
  String? enName;
  String? arName;
  String? enAddress;
  String? arAddress;
  String? enDesc;
  String? arDesc;
  String? phone;
  String? phone2;
  String? phone3;
  String? phone4;
  String? phone5;
  String? whatsapp;
  String? facebook;
  String? youtube;
  String? website;
  String? location;
  dynamic rating;
  List<Imgs>? imgs;

  OneStoreModel.fromJson(Map<String, dynamic>? json){
    id = json?['id'];
    enName = json?['en_name'];
    arName = json?['ar_name'];
    enAddress = json?['en_address'];
    arAddress = json?['ar_address'];
    enDesc = json?['en_desc'];
    arDesc = json?['ar_desc'];
    phone = json?['phone'];
    phone2 = json?['phone2'];
    phone3 = json?['phone3'];
    phone4 = json?['phone4'];
    phone5 = json?['phone5'];
    whatsapp = json?['whatsapp'];
    facebook = json?['facebook'];
    youtube = json?['youtube'];
    website = json?['website'];
    location = json?['location'];
    rating = json?['rating'];
    imgs = List.from(json?['imgs']).map((e)=>Imgs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['en_address'] = enAddress;
    data['ar_address'] = arAddress;
    data['en_desc'] = enDesc;
    data['ar_desc'] = arDesc;
    data['phone'] = phone;
    data['phone2'] = phone2;
    data['phone3'] = phone3;
    data['phone4'] = phone4;
    data['phone5'] = phone5;
    data['whatsapp'] = whatsapp;
    data['facebook'] = facebook;
    data['youtube'] = youtube;
    data['website'] = website;
    data['location'] = location;
    data['rating'] = rating;
    data['imgs'] = imgs!.map((e)=>e.toJson()).toList();
    return data;
  }
}

class Imgs {
  Imgs({
    this.img,
  });
  String? img;

  Imgs.fromJson(Map<String, dynamic>? json){
    img = json?['img'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['img'] = img;
    return data;
  }
}