class OfferItem {
  String title;
  List<String> offerImages;
  String description;
  String storeName;
  String date;
  bool type;

  OfferItem({required this.title, required this.offerImages, required this.description, required this.storeName,required this.date,required this.type});

  factory OfferItem.fromJson(Map<String, dynamic> json) {
    return OfferItem(
      title: json['title'],
      offerImages: List<String>.from(json['offerImages']),
      description: json['description'],
      storeName: json['storeName'],
      date: json['date'],
      type: json['type']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "offerImages": offerImages,
      "description": description,
      "storeName": storeName,
      "date": date,
      "type": type
    };
  }
}