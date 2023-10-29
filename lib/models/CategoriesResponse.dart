class CategoriesResponse {
  CategoriesResponse({
    this.genres,
  });

  CategoriesResponse.fromJson(dynamic json) {
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(GenresModel.fromJson(v));
      });
    }
  }

  List<GenresModel>? genres;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class GenresModel {
  GenresModel({
    this.id,
    this.name,
  });

  GenresModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
