import 'package:flutter/material.dart';
import 'package:lighthouse/services/post.dart';

class PostDetails extends StatelessWidget {
  final MissingPost post;
  const PostDetails({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(post.pictureUrl),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              post.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            title: const Text('Address'),
            subtitle: Text(post.address),
          ),
          ListTile(
            title: const Text('Location'),
            subtitle: Text('${post.latitude}, ${post.longitude}'),
          ),
          ListTile(
            title: const Text('Last Seen'),
            subtitle: Text(post.lastSeen.toString()),
          ),
          ListTile(
            title: const Text('Age'),
            subtitle: Text(post.age.toString()),
          ),
          ListTile(
            title: const Text('Height'),
            subtitle: Text(post.height.toString()),
          ),
          ListTile(
            title: const Text('Hair Color'),
            subtitle: Text(post.hairColor),
          ),
          ListTile(
            title: const Text('Skin Color'),
            subtitle: Text(post.skinColor),
          ),
        ],
      ),
    );
  }
}
