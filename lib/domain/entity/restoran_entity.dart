import 'package:equatable/equatable.dart';

class RestoranListEntity extends Equatable {
  final bool error;
  final String message;
  final List<RestoranEntity> restorans;

  RestoranListEntity({this.restorans, this.message, this.error});

  @override
  List<Object> get props => [restorans, message, error];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['restaurants'] = this.restorans.map((v) => v.toJson()).toList();
    return data;
  }

  factory RestoranListEntity.fromJson(Map<String, dynamic> json) =>
      RestoranListEntity(
        error: json['error'],
        message: json['message'] ?? "",
        restorans: List<RestoranEntity>.from(json['restaurants']
            .map((restoran) => RestoranEntity.fromJson(restoran))),
      );
}

class RestoranEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String rating;

  RestoranEntity(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating});

  @override
  List<Object> get props => [id, name, description, pictureId, city, rating];

  factory RestoranEntity.fromJson(Map<String, dynamic> json) => RestoranEntity(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toString(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['pictureId'] = this.pictureId;
    data['city'] = this.city;
    data['rating'] = this.rating;
    return data;
  }
}
