# date_form_field

<img src="https://raw.githubusercontent.com/liou-jia-hao/flutter-date-time-field/master/demo/screenshot.gif" alt="Demo App" style="margin:auto" height="500">

<a href="https://pub.dev/packages/date_time_field"><img src="https://img.shields.io/pub/v/date_time_field.svg" alt="Pub"></a>
<a href="https://github.com/hacktons/convex_bottom_bar"><img src="https://img.shields.io/badge/platform-flutter-ff69b4.svg" alt="github"></a>
<a href="https://github.com/liou-jia-hao/flutter-date-time-field/blob/master/LICENSE"><img src="https://img.shields.io/github/license/liou-jia-hao/flutter-date-time-field.svg" alt="license"></a>

DateTimeField wraps a TextField and integrates it with the enclosing Form. This provides additional functionality, such as validation and integration with other FormField widgets.


## Getting Started 

Add this to your package's pubspec.yaml file:

```yml
dependencies:
  date_time_field: ^1.0.0
```

## Usage

import package
```dart
import 'package:date_time_field/date_time_field.dart';
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_field/date_time_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool loading = false;
  DateTime? dob;
  String name = '';

  late DateEditingController dobController;
  late TextEditingController mameController;
  @override
  void initState() {
    super.initState();
    dobController = DateEditingController(
      date: DateTime(2020, 1, 1),
      initialDate: DateTime(2020, 9, 1),
      firstDate: DateTime(2019, 3, 4),
      lastDate: DateTime(2022, 4, 4),
      format: DateFormat('yyyy/MM/dd'),
    );
    dobController.addListener(() => {dob = dobController.date});
    mameController = TextEditingController();
    mameController.addListener(() => {name = mameController.text});
  }

  @override
  void dispose() {
    dobController.dispose();
    mameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: ListView(
        children: [
          TextFormField(
            controller: mameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'My name',
              suffixIcon: IconButton(
                onPressed: mameController.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
          const SizedBox(height: 20),
          DateTimeField(
            controller: dobController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'My birthday',
              suffixIcon: IconButton(
                onPressed: dobController.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        tooltip: 'Submit',
        onPressed: () async {
          try {
            loading = true;
            setState(() {});
          } catch (error) {
          } finally {
            loading = false;
            setState(() {});
          }
        },
        backgroundColor: colorScheme.surface,
        child: loading
            ? const CircularProgressIndicator()
            : Icon(
                Icons.check,
                color: colorScheme.primary,
              ),
      ),
    );
  }
}
```