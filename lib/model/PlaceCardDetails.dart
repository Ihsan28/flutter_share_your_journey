import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceCardDetails {
  final String? id;
  final List<String>? images;
  final List<String>? videos;
  final String? title;
  final String? description;
  final String? location;
  final DateTime? time;

  // Constructor
  PlaceCardDetails({
    String? id,
    this.images,
    this.videos,
    this.title,
    this.description,
    this.location,
    this.time,
  }) : id = id ?? uuid.v4(); // If id is not provided, generate a new UUID

  // Factory method to convert the PlaceCard to/from JSON
  factory PlaceCardDetails.fromJson(Map<String, dynamic> json) =>
      PlaceCardDetails(
        id: json['id'] as String?,
        images: (json['images'] as List?)?.map((e) => e as String).toList(),
        videos: (json['videos'] as List?)?.map((e) => e as String).toList(),
        title: json['title'] as String?,
        description: json['description'] as String?,
        location: json['location'] as String?,
        time: json['time'] != null
            ? DateTime.parse(json['time'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'images': images,
        'videos': videos,
        'title': title,
        'description': description,
        'location': location,
        'time': time?.toIso8601String(),
      };
}
