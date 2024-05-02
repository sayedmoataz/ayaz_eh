///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class ParentCategory {
/*
{
  "id": "1",
  "en_name": "Medical services",
  "ar_name": "خدمات طبية",
  "img": "https://hadayekhof.com/dalel/uploads/categories/Medical Services.png"
}
*/

  String? id;
  String? enName;
  String? arName;
  String? img;

  ParentCategory({
    this.id,
    this.enName,
    this.arName,
    this.img,
  });
  ParentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    enName = json['en_name']?.toString();
    arName = json['ar_name']?.toString();
    img = json['img']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['img'] = img;
    return data;
  }
}
