import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lighthouse/services/navigation.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInScreen extends StatelessWidget {
  final form = FormGroup({
    'email': FormControl<String>(
        validators: [Validators.email, Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  SignInScreen({Key? key}) : super(key: key);

  void login(BuildContext context) async {
    if (form.valid) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: form.control('email').value,
            password: form.control('password').value);
        Navigation.state.pushReplacementNamed('/home');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      flex: 2,
                    ),
                    ReactiveTextField(
                      formControlName: 'email',
                      decoration: const InputDecoration(hintText: 'Email'),
                      showErrors: (control) => false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      decoration: const InputDecoration(hintText: 'Password'),
                      obscureText: true,
                      showErrors: (control) => false,
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: () => login(context),
                      child: const Text('Login'),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context).pushReplacementNamed('/signup'),
                      child: Text(
                        'Sign up',
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
