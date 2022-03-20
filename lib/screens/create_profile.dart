import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:lighthouse/services/navigation.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CreateProfile extends StatelessWidget {
  final form = FormGroup(
    {
      'name': FormControl<String>(validators: [Validators.required]),
      'age': FormControl<String>(validators: [Validators.required]),
      'phone': FormControl<PhoneNumber>(validators: [
        ((control) => control.value == null ? {'required': true} : null),
      ]),
      'address1': FormControl<String>(validators: [Validators.required]),
      'address2': FormControl<String>(validators: [Validators.required]),
      'city': FormControl<String>(validators: [Validators.required]),
      'state': FormControl<String>(validators: [Validators.required]),
      'postcode': FormControl<String>(validators: [Validators.required]),
      'country': FormControl<String>(validators: [Validators.required]),
    },
  );

  CreateProfile({Key? key}) : super(key: key);

  bool validatePhone(PhoneNumber phone) {
    Country country = countries
        .firstWhere((element) => "+${element.dialCode}" == phone.countryCode);
    return !(phone.number.length < country.minLength ||
        phone.number.length > country.maxLength);
  }

  void createProfile() {
    print(form.value);
    Navigation.state.pushReplacementNamed('/signupSuccess');
    // if (form.valid && validatePhone(form.control('phone').value)) {
    //   print('form valid');
    //   Navigation.state.pushReplacementNamed('/signupSuccess');
    // } else {
    //   print('form invalid');
    // }
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
                child: ListView(
                  //shrinkWrap: true,
                  children: [
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: const InputDecoration(hintText: 'Email'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'age',
                      decoration: const InputDecoration(hintText: 'Password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    IntlPhoneField(
                      initialCountryCode: 'DE',
                      onChanged: (newValue) =>
                          form.control('phone').updateValue(newValue),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'address1',
                      decoration:
                          const InputDecoration(hintText: 'Address Line 1'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'address2',
                      decoration:
                          const InputDecoration(hintText: 'Address Line 2'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ReactiveTextField(
                            formControlName: 'city',
                            decoration: const InputDecoration(hintText: 'City'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: ReactiveTextField(
                            formControlName: 'state',
                            decoration:
                                const InputDecoration(hintText: 'State'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ReactiveTextField(
                            formControlName: 'postcode',
                            decoration:
                                const InputDecoration(hintText: 'Postcode'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: ReactiveTextField(
                            formControlName: 'country',
                            decoration:
                                const InputDecoration(hintText: 'Country'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: createProfile,
                        child: const Text('Create'),
                      ),
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
