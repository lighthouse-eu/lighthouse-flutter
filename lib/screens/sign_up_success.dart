import 'package:flutter/material.dart';

class SignupSuccess extends StatelessWidget {
  const SignupSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Thank you for Signing up!',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const Text(
              'Click the link in your email to complete the signup process',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 64,
            ),
            ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushReplacementNamed('/signin'),
                child: const Text('Back to Login page'))
          ],
        ),
      ),
    );
  }
}
