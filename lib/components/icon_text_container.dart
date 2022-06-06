import 'package:flutter/material.dart';

class IconTextContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  const IconTextContainer({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 235, 235),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 60,
      child: Row(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
