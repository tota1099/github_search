import 'dart:convert';

import 'package:github_search/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String nickname;
  final String image;
  final String url;

  ResultSearchModel({this.nickname, this.image, this.url});

  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'image': image,
      'url': url,
    };
  }

  factory ResultSearchModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ResultSearchModel(
      nickname: map['nickname'],
      image: map['image'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultSearchModel.fromJson(String source) => ResultSearchModel.fromMap(json.decode(source));
}
