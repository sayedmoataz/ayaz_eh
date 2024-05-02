class OneOfferProfileModel{
  String? id;
  String? enTitle;
  String? arTitle;
  String? enBody;
  String? arBody;
  String? storeID;
  String? enName;
  String? arName;
  List<Imgs> imgs = [];
  OneOfferProfileModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    enTitle = json['title_en'];
    arTitle = json['title_ar'];
    enBody = json['body_en'];
    arBody = json['body_ar'];
    storeID = json['store_id'];
    enName = json['store_en_name'];
    arName = json['store_ar_name'];
    if (json['imgs'] != null) {
      json['imgs'].forEach((v) {
        imgs.add(Imgs.fromJson(v));
      });
    }

  }
}
class Imgs {
  String? img;

  Imgs.fromJson(Map<String, dynamic> json) {
    img = json['img'];
  }
}

