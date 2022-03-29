import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:place_picker/place_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NewPost extends StatelessWidget {
  final form = FormGroup(
    {
      'picture': FormControl<XFile>(),
      'name': FormControl<String>(validators: [Validators.required]),
      'gender': FormControl<String>(validators: [Validators.required]),
      'age': FormControl<String>(
          validators: [Validators.required, Validators.number]),
      'skinColor': FormControl<String>(validators: [Validators.required]),
      'hairColor': FormControl<String>(validators: [Validators.required]),
      'location': FormControl<LocationResult>(),
      'time': FormControl<TimeOfDay>(),
      'date': FormControl<DateTime>(),
      'description': FormControl<String>(validators: [Validators.required]),
      'terms': FormControl<bool>(validators: [Validators.requiredTrue]),
      'acknowledge': FormControl<bool>(validators: [Validators.requiredTrue]),
    },
  );

  NewPost({Key? key}) : super(key: key);

  void signup() {
    print(form.value);
  }

  void showPlacePicker(BuildContext context) async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyDZUlbnKsJihZ1S2NRB-LbwMVuk5r3M9ZM",
            )));
    form.control('location').updateValue(result);
  }

  void pickImage() async {
    final _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      form.control('picture').updateValue(image);
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
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(
                child: ListView(
                  children: [
                    ReactiveValueListenableBuilder(
                      formControlName: 'picture',
                      builder: (context, control, child) => GestureDetector(
                        onTap: pickImage,
                        child: Center(
                          child: CircleAvatar(
                            child: control.value == null
                                ? const Icon(Icons.add_a_photo_outlined)
                                : null,
                            backgroundImage: control.value != null
                                ? FileImage(File((control.value as XFile).path))
                                : null,
                            radius: 50,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
                            keyboardType: TextInputType.number,
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
                    GestureDetector(
                      onTap: () => showPlacePicker(context),
                      child: ReactiveValueListenableBuilder(
                        formControlName: 'location',
                        builder: (context, control, child) => IconTextContainer(
                            text: (control.value as LocationResult?)
                                    ?.formattedAddress ??
                                'Location',
                            icon: Icons.pin_drop_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveTimePicker(
                      formControlName: 'time',
                      builder: (context, picker, child) => GestureDetector(
                        onTap: picker.showPicker,
                        child: IconTextContainer(
                          text: picker.value?.toString() ?? 'Time',
                          icon: Icons.schedule_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReactiveDatePicker(
                      formControlName: 'date',
                      builder: (context, picker, child) => GestureDetector(
                        onTap: picker.showPicker,
                        child: IconTextContainer(
                          text: picker.value?.toString() ?? 'Date',
                          icon: Icons.calendar_month_outlined,
                        ),
                      ),
                      firstDate: DateTime(2010),
                      lastDate: DateTime.now(),
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
                    const SizedBox(
                      height: 10,
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
    );
  }
}
