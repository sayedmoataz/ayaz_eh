///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class Search {
/*
{
  "id": "27",
  "en_name": "كيان ماركت",
  "ar_name": "كيان ماركت",
  "img": "https://hadayekhof.com/dalel/uploads/stores/كيان ماركت1.jpg",
  "zone_en_name": "Wadi Hof",
  "zones_ar_name": "وادى حوف"
}
*/

  String? id;
  String? enName;
  String? arName;
  String? img;
  String? zoneEnName;
  String? zonesArName;

  Search({
    this.id,
    this.enName,
    this.arName,
    this.img,
    this.zoneEnName,
    this.zonesArName,
  });
  Search.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    enName = json['en_name']?.toString();
    arName = json['ar_name']?.toString();
    img = json['img']?.toString();
    zoneEnName = json['zone_en_name']?.toString();
    zonesArName = json['zones_ar_name']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['en_name'] = enName;
    data['ar_name'] = arName;
    data['img'] = img;
    data['zone_en_name'] = zoneEnName;
    data['zones_ar_name'] = zonesArName;
    return data;
  }
}