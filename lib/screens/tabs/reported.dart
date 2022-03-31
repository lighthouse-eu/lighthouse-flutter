import 'package:flutter/material.dart';
import 'package:lighthouse/components/missing_person_tile.dart';
import 'package:lighthouse/services/post.dart';

class ReportedTab extends StatelessWidget {
  final Future<List<MissingPost>> _getFuture =
      PostService().getMissingPosts(false);
  ReportedTab({Key? key}) : super(key: key);

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
              'Reported missing near you',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
                'These people have been reported close to your chosen location recently. You can view more information about them, or if you saw them somewhere, you can contact the people who are looking for them immediately. Feel free to get in touch with them even if you are unsure if you saw the right person, but make sure that you respect their privacy.'),
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
                separatorBuilder: (context, index) => const SizedBox(
                  height: 30,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
