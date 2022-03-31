import 'package:flutter/material.dart';

class TipsTab extends StatelessWidget {
  const TipsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        const Text(
          'Useful help and resources',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
        ),
        TipCard(
          title: 'How can I help?',
          textContent: 'Here’s the immediate course of action you should take if you encountered someone who is lost, and 5 steps you should take in order to help them.',
          textButton: 'Learn More',
          onPressed: () {},
        ),
        TipCard(
          title: 'Charities around you',
          textContent: 'Donate to these charities and participate in their activities in order to support the cause for missing people.',
          textButton: 'Learn More',
          onPressed: () {},
          color: const Color(0xFFD5F1D3),
        ),
        TipCard(
          title: 'Contact the authorities',
          textContent: 'If you have just encountered a lost person, contact the authorities right now and report the case so that the police can get involved.',
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
          Text(textContent),
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
