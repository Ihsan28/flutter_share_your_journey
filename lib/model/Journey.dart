import 'package:uuid/uuid.dart';

import 'PlaceCardDetails.dart';

const uuid = Uuid();

class Journey {
  final String? id;
  final String? name;
  final List<PlaceCardDetails>? places;

  Journey({String? id, this.name, this.places}) : id = id ?? uuid.v4();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        // For places, we'll convert each PlaceCardDetails to a map
        'places': places?.map((place) => place.toJson()).toList(),
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
    );
  }
}
