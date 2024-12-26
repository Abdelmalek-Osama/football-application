class TodayNews {
  TodayNews({
    required this.news,
    required this.newsSources,
  });

  final List<News> news;
  final List<NewsSource> newsSources;

  factory TodayNews.fromJson(Map<String, dynamic> json) {
    return TodayNews(
      news: json["news"] == null
          ? []
          : List<News>.from(json["news"]!.map((x) => News.fromJson(x))),
      newsSources: json["newsSources"] == null
          ? []
          : List<NewsSource>.from(
              json["newsSources"]!.map((x) => NewsSource.fromJson(x))),
    );
  }
}

class News {
  News({
    required this.id,
    required this.publishDate,
    required this.sourceId,
    required this.title,
    required this.image,
    required this.url,
    required this.isMagazine,
  });

  final int? id;
  final DateTime? publishDate;
  final int? sourceId;
  final String? title;
  final String? image;
  final String? url;
  final bool? isMagazine;

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json["id"],
      publishDate: DateTime.tryParse(json["publishDate"] ?? ""),
      sourceId: json["sourceId"],
      title: json["title"],
      image: json["image"],
      url: json["url"],
      isMagazine: json["isMagazine"],
    );
  }
}

class NewsSource {
  NewsSource({
    required this.id,
    required this.name,
    required this.imageVersion,
  });

  final int? id;
  final String? name;
  final int? imageVersion;

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: json["id"],
      name: json["name"],
      imageVersion: json["imageVersion"],
    );
  }
}
