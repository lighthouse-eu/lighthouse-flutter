import 'package:flutter/material.dart';

class TipsTab extends StatelessWidget {
  const TipsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: const [
        Text(
          'Useful help and resources',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
        ),
        TipCard(),
        TipCard(),
        TipCard(),
      ],
    );
  }
}

class TipCard extends StatelessWidget {
  const TipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color(0xFFEFF1D3),
      ),
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Tip 1',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 15,),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc posuere nisi arcu, eget eleifend justo porta fringilla. Proin nunc neque, facilisis quis vestibulum sit amet, ullamcorper in arcu. Proin venenatis, erat sed dictum tincidunt, massa sapien consectetur sem, a congue massa massa eget sapien. Integer at pellentesque lectus. Integer eget nisl eget orci tristique bibendum. Vivamus velit dui, porta eu libero ut, auctor aliquam sapien. Sed at maximus sem, sed venenatis turpis. Nulla ultricies elit ligula, vel faucibus ante luctus eu. Proin non viverra elit, a semper leo. '),
        ],
      ),
    );
  }
}
