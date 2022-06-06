import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String phone;
  final double lat;
  final double long;
  final String fcmToken;

  UserProfile({
    required this.phone,
    required this.lat,
    required this.long,
    required this.fcmToken,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
      phone: json["name"],
      lat: json["lat"],
      long: json["long"],
      fcmToken: json["fcmToken"]);

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "lat": lat,
        "long": long,
        'fcmToken': fcmToken,
      };
}

class ProfileService {
  final CollectionReference<UserProfile> profiles = FirebaseFirestore.instance
      .collection('profiles')
      .withConverter<UserProfile>(
        fromFirestore: (doc, options) => UserProfile.fromJson(doc.data()!),
        toFirestore: (profile, options) => profile.toJson(),
      );

  Future<void> createProfile(String uid, UserProfile profile) async {
    profiles.doc(uid).set(profile);
  }
}
