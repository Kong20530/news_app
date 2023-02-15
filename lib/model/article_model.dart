import 'package:news_app/model/source_model.dart';

class ArticleModel {
  ArticleModel(
      this.source,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content
      );

  String? author;
  String? description;
  String? urlToImage;
  String? content;
  String title;
  String url;
  String publishedAt;
  SourceModel source;

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'description': description,
      'urlToImage': urlToImage,
      'content': content,
      'title': title,
      'url': url,
      'publishedAt': publishedAt,
      'source': source,
    };
}

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    SourceModel.fromJson(json['source'] as Map<String, dynamic>),
    json['author'],
    json['title'],
    json['description'],
    json['url'],
    json['urlToImage'],
    json['publishedAt'],
    json['content'],
  );
}
