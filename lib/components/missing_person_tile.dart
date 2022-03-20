import 'package:flutter/material.dart';

class MissingPersonTile extends StatelessWidget {
  const MissingPersonTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network('https://image.shutterstock.com/mosaic_250/101595/1812937819/stock-photo-portrait-of-happy-mid-adult-man-sitting-on-sofa-at-home-handsome-latin-man-in-casual-relaxing-on-1812937819.jpg', fit: BoxFit.contain,),
        const SizedBox(height: 10,),
        const Text(
          'Adam, Male, 31, 6\'1\'\'',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          'Went missing 2d ago near Bremen, Germany',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        const Text(
          'Wore a blue denim jacket, black jeans and a white AC/DC t-shirt the last time we saw him. Also had a blue cap on. Was on his way to grab a doner from Gul Imbiss, but never returned and his phone went off as well. ',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => print('asd'),
              child: const Text(
                'See More',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade200,
                onPrimary: Colors.black
              ),
            ),
            ElevatedButton(
              onPressed: () => print('asd'),
              child: const Text('Contact'),
            ),
          ],
        ),
      ],
    );
  }
}
