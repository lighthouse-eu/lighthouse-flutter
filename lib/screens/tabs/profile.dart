import 'package:firebase_auth/firebase_auth.dart';
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
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            FirebaseAuth.instance.currentUser!.email!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Center(
          child: Text(
            FirebaseAuth.instance.currentUser!.uid,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
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
        const SizedBox(
          height: 40,
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/signin');
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.grey.shade200, onPrimary: Colors.red),
            child: const Text(
              'Sign out',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
