import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class PostService {
  final CollectionReference<MissingPost> missing = FirebaseFirestore.instance
      .collection('missing')
      .withConverter<MissingPost>(
        fromFirestore: (doc, options) => MissingPost.fromJson(doc.data()!),
        toFirestore: (post, options) => post.toJson(),
      );
  final CollectionReference<SpottedPost> spotted = FirebaseFirestore.instance
      .collection('spotted')
      .withConverter<SpottedPost>(
        fromFirestore: (doc, options) => SpottedPost.fromJson(doc.data()!),
        toFirestore: (post, options) => post.toJson(),
      );

  Future<void> addMissingPost(MissingPost post) async {
    missing.add(post);
  }

  Future<void> addSpottedPost(SpottedPost post) async {
    spotted.add(post);
  }
}

class MissingPost {
  MissingPost({
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.timePosted,
    required this.lastSeen,
    required this.contactDetails,
    required this.skinColor,
    required this.hairColor,
  });

  final String name;
  final String gender;
  final int age;
  final int height;
  final String description;
  final double latitude;
  final double longitude;
  final int timePosted;
  final int lastSeen;
  final String contactDetails;
  final String skinColor;
  final String hairColor;

  factory MissingPost.fromRawJson(String str) =>
      MissingPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MissingPost.fromJson(Map<String, dynamic> json) => MissingPost(
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        height: json["height"],
        description: json["description"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        timePosted: json["time_posted"],
        lastSeen: json["last_seen"],
        contactDetails: json["contact_details"],
        skinColor: json["skin_color"],
        hairColor: json["hair_color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "age": age,
        "height": height,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "time_posted": timePosted,
        "last_seen": lastSeen,
        "contact_details": contactDetails,
        "skin_color": skinColor,
        "hair_color": hairColor,
      };
}

class SpottedPost {
  SpottedPost({
    required this.name,
    required this.gender,
    required this.age,
    required this.height,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.timePosted,
    required this.lastSeen,
    required this.contactDetails,
    required this.skinColor,
    required this.hairColor,
  });

  final String name;
  final String gender;
  final int age;
  final int height;
  final String description;
  final double latitude;
  final double longitude;
  final int timePosted;
  final int lastSeen;
  final String contactDetails;
  final String skinColor;
  final String hairColor;

  factory SpottedPost.fromRawJson(String str) =>
      SpottedPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpottedPost.fromJson(Map<String, dynamic> json) => SpottedPost(
        name: json["name"],
        gender: json["gender"],
        age: json["age"],
        height: json["height"],
        description: json["description"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        timePosted: json["time_posted"],
        lastSeen: json["last_seen"],
        contactDetails: json["contact_details"],
        skinColor: json["skin_color"],
        hairColor: json["hair_color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": gender,
        "age": age,
        "height": height,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "time_posted": timePosted,
        "last_seen": lastSeen,
        "contact_details": contactDetails,
        "skin_color": skinColor,
        "hair_color": hairColor,
      };
}
