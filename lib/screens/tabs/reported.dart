import 'package:flutter/material.dart';
import 'package:lighthouse/components/missing_person_tile.dart';

class ReportedTab extends StatelessWidget {
  const ReportedTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: FutureBuilder(
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Reported missing near you',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                    'These people have been reported close to your chosen location recently. You can view more information about them, or if you saw them somewhere, you can contact the people who are looking for them immediately. Feel free to get in touch with them even if you are unsure if you saw the right person, but make sure that you respect their privacy.'),
              ),
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
