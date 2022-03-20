import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignUpScreen extends StatelessWidget {
  final form = FormGroup(
    {
      'email': FormControl<String>(validators: [Validators.email]),
      'password': FormControl<String>(),
      'confirmPassword': FormControl<String>(),
    },
    validators: [Validators.mustMatch('password', 'confirmPassword')],
  );

  SignUpScreen({Key? key}) : super(key: key);

  void signup() {
    print(form.value);
    print(form.control('password').value);
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'password',
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'confirmPassword',
                      decoration: const InputDecoration(hintText: 'Confirm Password'),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    ElevatedButton(
                      onPressed: signup,
                      child: const Text('Login'),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacementNamed('/signin'),
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
