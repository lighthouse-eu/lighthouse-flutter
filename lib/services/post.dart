import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class PostService {
  final CollectionReference<MissingPost> reported = FirebaseFirestore.instance
      .collection('reported')
      .withConverter<MissingPost>(
        fromFirestore: (doc, options) => MissingPost.fromJson(doc.data()!),
        toFirestore: (post, options) => post.toJson(),
      );
  final CollectionReference<MissingPost> spotted = FirebaseFirestore.instance
      .collection('spotted')
      .withConverter<MissingPost>(
        fromFirestore: (doc, options) => MissingPost.fromJson(doc.data()!),
        toFirestore: (post, options) => post.toJson(),
      );

  Future<void> addMissingPost(MissingPost post, bool isSpotted) async {
    if (isSpotted) {
      spotted.add(post);
    } else {
      reported.add(post);
    }
  }

  Future<List<MissingPost>> getMissingPosts(bool isSpotted) async {
    var query = isSpotted ? await spotted.get() : await reported.get();
    return query.docs.map((e) => e.data()).toList();
  }
}

class MissingPost {
  MissingPost({
    required this.name,
    required this.pictureUrl,
    required this.gender,
    required this.age,
    required this.height,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.timePosted,
    required this.lastSeen,
    required this.contactDetails,
    required this.skinColor,
    required this.hairColor,
  });

  final String name;
  final String pictureUrl;
  final String gender;
  final int age;
  final double height;
  final String description;
  final double latitude;
  final double longitude;
  final String address;
  final DateTime timePosted;
  final DateTime lastSeen;
  final String contactDetails;
  final String skinColor;
  final String hairColor;

  factory MissingPost.fromRawJson(String str) =>
      MissingPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MissingPost.fromJson(Map<String, dynamic> json) => MissingPost(
        name: json["name"],
        pictureUrl: json["pictureUrl"],
        gender: json["gender"],
        age: json["age"],
        height: json["height"],
        description: json["description"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        address: json['address'],
        timePosted: (json["time_posted"] as Timestamp).toDate(),
        lastSeen: (json["last_seen"] as Timestamp).toDate(),
        contactDetails: json["contact_details"],
        skinColor: json["skin_color"],
        hairColor: json["hair_color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pictureUrl": pictureUrl,
        "gender": gender,
        "age": age,
        "height": height,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        'address': address,
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
    required this.pictureUrl,
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
  final String pictureUrl;
  final String gender;
  final int age;
  final double height;
  final String description;
  final double latitude;
  final double longitude;
  final DateTime timePosted;
  final DateTime lastSeen;
  final String contactDetails;
  final String skinColor;
  final String hairColor;

  factory SpottedPost.fromRawJson(String str) =>
      SpottedPost.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpottedPost.fromJson(Map<String, dynamic> json) => SpottedPost(
        name: json["name"],
        pictureUrl: json["pictureUrl"],
        gender: json["gender"],
        age: json["age"],
        height: json["height"],
        description: json["description"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        timePosted: (json["time_posted"] as Timestamp).toDate(),
        lastSeen: (json["last_seen"] as Timestamp).toDate(),
        contactDetails: json["contact_details"],
        skinColor: json["skin_color"],
        hairColor: json["hair_color"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "pictureUrl": pictureUrl,
        "gender": gender,
        "age": age,
        "height": height,
        "description": description,
        "latitude": latitude,
        "longitude": longitude,
        "time_posted": Timestamp.fromDate(timePosted),
        "last_seen": Timestamp.fromDate(lastSeen),
        "contact_details": contactDetails,
        "skin_color": skinColor,
        "hair_color": hairColor,
      };
}
