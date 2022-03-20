import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NewPost extends StatelessWidget {
  final form = FormGroup(
    {
      'name': FormControl<String>(),
      'gender': FormControl<String>(),
      'age': FormControl<String>(),
      'skinColor': FormControl<String>(),
      'hairColor': FormControl<String>(),
      'location': FormControl<String>(),
      'time': FormControl<String>(),
      'description': FormControl<String>(),
      'terms': FormControl<bool>(),
      'acknowledge': FormControl<bool>(),
    },
  );

  NewPost({Key? key}) : super(key: key);

  void signup() {
    print(form.value);
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: ListView(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        child: Icon(Icons.add_a_photo),
                        radius: 50,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    ReactiveTextField(
                      formControlName: 'name',
                      decoration: const InputDecoration(hintText: 'Name'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: ReactiveTextField(
                            formControlName: 'gender',
                            decoration:
                                const InputDecoration(hintText: 'Gender'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: ReactiveTextField(
                            formControlName: 'age',
                            decoration: const InputDecoration(hintText: 'Age'),
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
                            formControlName: 'skinColor',
                            decoration:
                                const InputDecoration(hintText: 'Skin Color'),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: ReactiveTextField(
                            formControlName: 'hairColor',
                            decoration:
                                const InputDecoration(hintText: 'Hair Color'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'location',
                      decoration: const InputDecoration(hintText: 'Location'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'time',
                      decoration: const InputDecoration(hintText: 'Time'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTextField(
                      formControlName: 'description',
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveCheckboxListTile(
                      formControlName: 'terms',
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                          'I agree with Lighthouse terms and conditions of submission.'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveCheckboxListTile(
                      formControlName: 'acknowledge',
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                          'I acknowledge that the information I provide is to the best of my knowledge. I acknowledge that this is a very sensitive matter, and matters of life and death may depend on my submission to Lighthouse.'),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: signup,
                        child: const Text('Submit'),
                      ),
                    ),
                    const SizedBox(height: 10,),
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
