import 'package:flutter/material.dart';
import 'package:lighthouse/services/navigation.dart';

class TipsTab extends StatelessWidget {
  const TipsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        const Text(
          'Useful help and resources',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        const HeroTipCard(
            heroTag: 'help',
            title: 'How can I help?',
            content:
                'The immediate course of action you should take if you encountered someone who is lost.',
            subtitle: 'How can I help?',
            subContent:
                'Generate Post on LightHouse App - Post about the found person with their relevant bio-data and the location they were found at through the LightHouse App.\n\nContact Nearby NGOS - You can look for nearby NGOs/charities and contact them to rescue the found person.The organizations would provide temporary shelter to the found person until they are reunited with their family members.\n\nInform Local Authorities - Inform the local authorities/police about the found person. Inform them of the relevant NGO if you have planned on seeking their help to rescue the found person.'),
        TipCard(
          title: 'Charities around you',
          textContent:
              'Donate to these charities and participate in their activities in order to support the cause for missing people.',
          textButton: 'Learn More',
          onPressed: () {},
          color: const Color(0xFFD5F1D3),
        ),
        TipCard(
          title: 'Contact the authorities',
          textContent:
              'If you have just encountered a lost person, contact the authorities right now and report the case so that the police can get involved.',
          textButton: 'Call now',
          onPressed: () {},
          color: const Color(0xFFF1DAD3),
        ),
      ],
    );
  }
}

class TipCard extends StatelessWidget {
  final Color color;
  final String title;
  final String textContent;
  final String textButton;
  final VoidCallback onPressed;
  const TipCard({
    Key? key,
    this.color = const Color(0xFFEFF1D3),
    required this.title,
    required this.textContent,
    required this.textButton,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: color,
      ),
      padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            textContent,
            overflow: TextOverflow.clip,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onPressed,
              child: Text(textButton),
            ),
          ),
        ],
      ),
    );
  }
}

class HeroTipCard extends StatelessWidget {
  final String heroTag;
  final String title;
  final String content;
  final String subtitle;
  final String subContent;
  const HeroTipCard(
      {Key? key,
      required this.heroTag,
      required this.title,
      required this.content,
      required this.subtitle,
      required this.subContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Material(
        child: TipCard(
          title: title,
          textContent: content,
          textButton: 'Learn More',
          onPressed: () {
            Navigation.state.push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                ),
                body: Hero(
                  tag: heroTag,
                  child: Material(
                    child: TipCard(
                      title: subtitle,
                      textContent: subContent,
                      textButton: '',
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
