import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Center(
          child: CircleAvatar(
            radius: 50,
          ),
        ),
        const SizedBox(height: 10,),
        const Center(
          child: Text(
            'John Adam',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        const Center(
          child: Text(
            'Bremen, Germany',
          ),
        ),
        const SizedBox(height: 30,),
        const ListTile(
          title: Text('My Active Posts'),
        ),
        const ListTile(
          title: Text('Change email'),
        ),
        const ListTile(
          title: Text('Change password'),
        ),
        const ListTile(
          title: Text('Change phone number'),
        ),
        const ListTile(
          title: Text('Donate to us'),
        ),
        const ListTile(
          title: Text('Contact Local Authorities'),
        ),
        const ListTile(
          title: Text('Helpful NGOs and Charities'),
        ),
        const SizedBox(height: 40,),
        Center(
          child: ElevatedButton(
            onPressed: () => print('asd'),
            child: const Text(
              'Sign out',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade200,
                onPrimary: Colors.red
            ),
          ),
        ),
      ],
    );
  }
}