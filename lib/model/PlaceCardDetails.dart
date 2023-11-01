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
  }) : id = id ?? uuid.v4();

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

  // Dummy data
  static List<PlaceCardDetails> touristPlaces = [
    PlaceCardDetails(
      title: 'Cox\'s Bazar',
      description: 'World\'s longest natural sandy sea beach.',
      location: 'Cox\'s Bazar',
      time: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1685429894355-1138741e58c6?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDF8NnNNVmpUTFNrZVF8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1698255674147-5a7177ef0bfe?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDR8NnNNVmpUTFNrZVF8fGVufDB8fHx8fA%3D%3D',
      ],
    ),
    PlaceCardDetails(
      title: 'Sundarbans Mangrove Forest',
      description:
          'Largest mangrove forest in the world and home to the Bengal tiger.',
      location: 'Sundarbans Mangrove Forest',
      time: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1698117030662-2a5c5243efee?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDJ8NnNNVmpUTFNrZVF8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1698303715502-2ae80fb90af5?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDN8NnNNVmpUTFNrZVF8fGVufDB8fHx8fA%3D%3D',
      ],
    ),
    PlaceCardDetails(
      title: 'St. Martin\'s Island',
      description: 'A beautiful coral island in the Bay of Bengal.',
      location: 'Bay of Bengal, Bangladesh',
      time: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1698213120340-3fd8fca285ea?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDZ8NnNNVmpUTFNrZVF8fGVufDB8fHx8fA%3D%3D',
        'https://images.unsplash.com/photo-1698245279265-64710170e5ae?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDV8NnNNVmpUTFNrZVF8fGVufDB8fHx8fA%3D%3D',
      ],
    ),
    PlaceCardDetails(
      title: 'Rangamati',
      description:
          'Known for its landscape, scenic beauty, and tribal culture.',
      location: 'Rangamati, Bangladesh',
      time: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1695185034951-1ae999cb2e93?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDExfDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D',
        'https://images.unsplash.com/photo-1698209237983-00fc4b302749?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDd8NnNNVmpUTFNrZVF8fGVufDB8fHx8fA%3D%3D',
      ],
    ),
    PlaceCardDetails(
      title: 'Srimangal',
      description: 'The Tea Capital of Bangladesh.',
      location: 'Srimangal, Bangladesh',
      time: DateTime.now(),
      images: [
        'https://images.unsplash.com/photo-1695982206538-d0acf0c1cb06?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDEyfDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D',
        'https://images.unsplash.com/photo-1698005156356-6bbf40b61f8c?auto=format&fit=crop&q=60&w=500&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDEwfDZzTVZqVExTa2VRfHxlbnwwfHx8fHw%3D',
      ],
    ),
  ];
}
