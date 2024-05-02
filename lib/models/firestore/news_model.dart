class NewsItem {
  String title;
  String newsImage;
  String description;
  String date;

  NewsItem({required this.title, required this.newsImage, required this.description, required this.date});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'],
      newsImage: json['newsImage'],
      description: json['description'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "newsImage": newsImage,
      "description": description,
      "date": date
    };
  }
}