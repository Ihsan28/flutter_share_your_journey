import 'package:uuid/uuid.dart';

import 'PlaceCardDetails.dart';

const uuid = Uuid();

class Journey {
  final String? id;
  final String? name;
  final List<PlaceCardDetails>? places;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;

  Journey({
    String? id,
    this.name,
    this.places,
    DateTime? createdDate,
    DateTime? lastModifiedDate,
  })  : id = id ?? uuid.v4(),
        createdDate = createdDate ?? DateTime.now(),
        lastModifiedDate = lastModifiedDate ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'places': places?.map((place) => place.toJson()).toList(),
        'createdDate': createdDate?.toIso8601String(),
        'lastModifiedDate': lastModifiedDate?.toIso8601String(),
      };

  // Factory method to convert a Journey from JSON
  factory Journey.fromJson(Map<String, dynamic> json) {
    var placesFromJson = json['places'] as List;
    List<PlaceCardDetails> placesList = placesFromJson
        .map((place) => PlaceCardDetails.fromJson(place))
        .toList();

    return Journey(
      id: json['id'] as String?,
      name: json['name'] as String?,
      places: placesList,
      createdDate: DateTime.parse(json['createdDate'] as String),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate'] as String),
    );
  }
}
