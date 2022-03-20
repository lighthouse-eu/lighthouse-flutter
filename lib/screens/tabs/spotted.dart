import 'package:flutter/material.dart';
import 'package:lighthouse/components/missing_person_tile.dart';

class SpottedTab extends StatelessWidget {
  const SpottedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: FutureBuilder(
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Last spotted near you',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
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
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) => const MissingPersonTile(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 30,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
