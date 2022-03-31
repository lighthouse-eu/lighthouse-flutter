import 'package:flutter/material.dart';
import 'package:lighthouse/screens/post_details.dart';
import 'package:lighthouse/services/post.dart';

class MissingPersonTile extends StatelessWidget {
  final MissingPost post;
  const MissingPersonTile({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          post.pictureUrl,
          height: 200,
          fit: BoxFit.fitHeight,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          '${post.name}, ${post.gender}, ${post.age}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'Went missing ${DateTime.now().difference(post.timePosted).inDays}d ago near ${post.address}',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          'Posted on ${post.timePosted.day}.${post.timePosted.month}.${post.timePosted.year}, ${post.timePosted.hour}:${post.timePosted.minute}',
          style: const TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          post.description,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostDetails(post: post),
                fullscreenDialog: true,
              )),
              child: const Text(
                'See More',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.grey.shade200, onPrimary: Colors.black),
            ),
            ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Contact Details'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text.rich(
                        TextSpan(
                            text: 'Email: ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: post.contactDetails,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal)),
                            ]),
                      ),
                      const Text.rich(
                        TextSpan(
                            text: 'Phone: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: 'N/A',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ]),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: Navigator.of(context).pop,
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
              child: const Text('Contact'),
            ),
          ],
        ),
      ],
    );
  }
}
