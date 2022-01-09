import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_field/date_time_field.dart';

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
            // TODO: update some value
          } catch (error) {
            debugPrint(error.toString());
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
