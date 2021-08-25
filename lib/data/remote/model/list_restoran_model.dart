import 'package:equatable/equatable.dart';

class RestoranListModel extends Equatable {
  final bool error;
  final String message;
  final int count;
  final int found;
  final List<RestoranModel> restorans;

  RestoranListModel(
      {this.restorans, this.error, this.message, this.count, this.found});

  @override
  List<Object> get props => [restorans, error, message, count, found];

  factory RestoranListModel.fromJson(Map<String, dynamic> json) =>
      RestoranListModel(
        error: json['error'],
        message: json['message'] ?? "",
        count: json['count'] ?? 0,
        found: json['found'] ?? 0,
        restorans: List<RestoranModel>.from(json['restaurants']
            .map((restoran) => RestoranModel.fromJson(restoran))),
      );
}

class RestoranModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  RestoranModel(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating});

  @override
  List<Object> get props => [id, name, description, pictureId, city, rating];

  factory RestoranModel.fromJson(Map<String, dynamic> json) => RestoranModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        rating: json['rating'].toDouble(),
      );
}
