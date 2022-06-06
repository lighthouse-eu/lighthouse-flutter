import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/components/icon_text_container.dart';
import 'package:lighthouse/keys.dart';
import 'package:lighthouse/services/navigation.dart';
import 'package:lighthouse/services/profile.dart';
import 'package:place_picker/place_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends StatelessWidget {
  final form = FormGroup(
    {
      'email': FormControl<String>(
          validators: [Validators.email, Validators.required]),
      'password': FormControl<String>(validators: [Validators.required]),
      'confirmPassword': FormControl<String>(validators: [Validators.required]),
      'phone': FormControl<String>(validators: [Validators.required]),
      'location': FormControl<LocationResult>(
        validators: [Validators.required],
      )
    },
    validators: [Validators.mustMatch('password', 'confirmPassword')],
  );

  SignUpScreen({Key? key}) : super(key: key);

  void showPlacePicker(BuildContext context) async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              Platform.isAndroid ? androidMapsKey : iosMapsKey,
            )));
    if (result != null) {
      form.control('location').updateValue(result);
    }
  }

  void signup(BuildContext context) async {
    if (form.valid) {
      try {
        var userCred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: form.control('email').value,
                password: form.control('password').value);
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken == null) {
          throw FirebaseAuthException(code: '');
        }
        var profile = UserProfile(
          phone: form.control('phone').value,
          lat: (form.control('location').value as LocationResult)
              .latLng!
              .latitude,
          long: (form.control('location').value as LocationResult)
              .latLng!
              .longitude,
          fcmToken: fcmToken,
        );
        ProfileService().createProfile(userCred.user!.uid, profile);
        Navigation.state.pushReplacementNamed('/signupSuccess');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth < 500 ? null : 500,
          child: SingleChildScrollView(
            child: ReactiveForm(
              formGroup: form,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/logo_big_black.png',
                        fit: BoxFit.fitWidth,
                      ),
                      ReactiveTextField(
                        formControlName: 'email',
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReactiveTextField(
                        formControlName: 'password',
                        decoration: const InputDecoration(hintText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReactiveTextField(
                        formControlName: 'confirmPassword',
                        decoration:
                            const InputDecoration(hintText: 'Confirm Password'),
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => showPlacePicker(context),
                        child: ReactiveValueListenableBuilder(
                          formControlName: 'location',
                          builder: (context, control, child) =>
                              IconTextContainer(
                                  text: (control.value as LocationResult?)
                                          ?.formattedAddress ??
                                      'Location',
                                  icon: Icons.pin_drop_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReactiveTextField(
                        formControlName: 'phone',
                        decoration:
                            const InputDecoration(hintText: 'Phone number'),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                        onPressed: () => signup(context),
                        child: const Text('Sign up'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context)
                              .pushReplacementNamed('/signin'),
                          child: Text(
                            'Login instead',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
