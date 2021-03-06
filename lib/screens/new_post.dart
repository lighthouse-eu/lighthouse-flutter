import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lighthouse/components/icon_text_container.dart';
import 'package:lighthouse/keys.dart';
import 'package:lighthouse/services/post.dart';
import 'package:place_picker/place_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:uuid/uuid.dart';

class NewPost extends StatefulWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final form = FormGroup(
    {
      'picture': FormControl<File>(validators: [Validators.required]),
      'isSpotted':
          FormControl<bool>(value: false, validators: [Validators.required]),
      'name': FormControl<String>(validators: [Validators.required]),
      'gender': FormControl<String>(validators: [Validators.required]),
      'age': FormControl<String>(
          validators: [Validators.required, Validators.number]),
      'height': FormControl<String>(validators: [Validators.required]),
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

  Future<void> addMissingPost(BuildContext context) async {
    if (form.invalid) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form is invalid or incomplete')));
      return;
    }

    var id = const Uuid().v1();
    var postType = form.control('isSpotted').value ? 'spotted' : 'reported';
    var pictureType =
        (form.control('picture').value as File).path.split('.').last;
    var pictureRef = FirebaseStorage.instance.ref('$postType/$id.$pictureType');
    late String pictureUrl;

    try {
      await pictureRef.putFile(form.control('picture').value);
      pictureUrl = await pictureRef.getDownloadURL();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }

    DateTime date = form.control('date').value;
    TimeOfDay time = form.control('time').value;

    var newPost = MissingPost(
      name: form.control('name').value,
      pictureUrl: pictureUrl,
      gender: form.control('gender').value,
      age: int.parse(form.control('age').value),
      height: double.parse(form.control('height').value),
      description: form.control('description').value,
      latitude:
          (form.control('location').value as LocationResult).latLng!.latitude,
      longitude:
          (form.control('location').value as LocationResult).latLng!.longitude,
      address:
          (form.control('location').value as LocationResult).formattedAddress!,
      timePosted: DateTime.now(),
      lastSeen:
          DateTime(date.year, date.month, date.day, time.hour, time.minute),
      contactDetails: FirebaseAuth.instance.currentUser!.email!,
      skinColor: form.control('skinColor').value,
      hairColor: form.control('hairColor').value,
    );

    await PostService()
        .addMissingPost(newPost, form.control('isSpotted').value);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Post created!')));
  }

  void showPlacePicker(BuildContext context) async {
    LocationResult? result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              Platform.isAndroid ? androidMapsKey : iosMapsKey,
            )));
    if (result != null) {
      form.control('location').updateValue(result);
    }
  }

  void pickImage() async {
    final picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var file = File(image.path);
        form.control('picture').updateValue(file);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong whiile getting your image.')));
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
                            backgroundImage: control.value != null
                                ? FileImage(control.value as File)
                                : null,
                            radius: 50,
                            child: control.value == null
                                ? const Icon(Icons.add_a_photo_outlined)
                                : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Missing'),
                        ReactiveSwitch(
                          formControlName: 'isSpotted',
                          inactiveTrackColor: Colors.blue.shade200,
                          inactiveThumbColor: Colors.blue,
                        ),
                        const Text('Spotted')
                      ],
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
                            formControlName: 'height',
                            decoration:
                                const InputDecoration(hintText: 'Height'),
                            keyboardType: TextInputType.number,
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
                    ReactiveDropdownField<String>(
                      hint: const Text('Gender'),
                      formControlName: 'gender',
                      items: ['Male', 'Female']
                          .map((e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(e),
                              ))
                          .toList(),
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
                          text: picker.value != null
                              ? '${picker.value!.hour}:${picker.value!.minute}'
                              : 'Time',
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
                          text: picker.value != null
                              ? '${picker.value!.day}.${picker.value!.month}.${picker.value!.year}'
                              : 'Date',
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
                        onPressed: () => addMissingPost(context),
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
