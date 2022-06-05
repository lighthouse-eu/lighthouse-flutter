import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/services/navigation.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends StatelessWidget {
  final form = FormGroup(
    {
      'email': FormControl<String>(
          validators: [Validators.email, Validators.required]),
      'password': FormControl<String>(validators: [Validators.required]),
      'confirmPassword': FormControl<String>(validators: [Validators.required]),
    },
    validators: [Validators.mustMatch('password', 'confirmPassword')],
  );

  SignUpScreen({Key? key}) : super(key: key);

  void signup(BuildContext context) async {
    if (form.valid) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: form.control('email').value,
            password: form.control('password').value);
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
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.maxWidth < 500 ? null : 500,
          child: ReactiveForm(
            formGroup: form,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(
                      flex: 1,
                    ),
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
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () => signup(context),
                      child: const Text('Sign up'),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushReplacementNamed('/signin'),
                      child: Text(
                        'Login instead',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
