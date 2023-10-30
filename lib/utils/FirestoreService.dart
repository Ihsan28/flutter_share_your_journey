import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_your_journey/model/Journey.dart';

import '../model/PlaceCardDetails.dart';

class FirestoreService {
  final CollectionReference journeysCollection =
      FirebaseFirestore.instance.collection('journeys');

  Future<void> addJourney(Journey journey) async {
    try {
      DocumentReference journeyDocRef =
          await journeysCollection.add(journey.toJson());
      for (var place in journey.places!) {
        await journeyDocRef.collection('places').add(place.toJson());
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void storeJourneyInFirestore() async {
    FirestoreService firestoreService = FirestoreService();

    Journey journey = Journey(
      name: "My First Journey",
      places:
          PlaceCardDetails.touristPlaces, // Assuming this is a list of places
    );

    await firestoreService.addJourney(journey);
  }

  Future<void> addPlaceToJourney(
      String journeyId, PlaceCardDetails newPlace) async {
    // Fetch the specific journey document
    DocumentSnapshot journeySnapshot =
        await journeysCollection.doc(journeyId).get();

    if (journeySnapshot.exists) {
      // Convert the document snapshot to a Journey object
      Journey journey =
          Journey.fromJson(journeySnapshot.data() as Map<String, dynamic>);

      // Add the new place to the places list of the journey
      journey.places?.add(newPlace);

      // Update the journey document in Firestore
      await journeysCollection.doc(journeyId).update({
        'places': journey.places?.map((place) => place.toJson()).toList(),
      });
    } else {
      print('Journey not found!');
    }
  }
}
