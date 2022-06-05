import 'package:flutter/material.dart';
import 'package:lighthouse/components/missing_person_tile.dart';
import 'package:lighthouse/services/post.dart';

class SpottedTab extends StatelessWidget {
  final Future<List<MissingPost>> _getFuture =
      PostService().getMissingPosts(true);
  SpottedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MissingPost>>(
      initialData: const [],
      future: _getFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last spotted near you',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
                'These people were recently spotted close to you. If you have lost a loved one recently, someone may have found them, noticed they were lost and out of place, and posted about them here. This is especially true for children and the elderly. If you see a post about someone you know who went missing, you can contact them right away.'),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => MissingPersonTile(
                  post: snapshot.data![index],
                ),
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
