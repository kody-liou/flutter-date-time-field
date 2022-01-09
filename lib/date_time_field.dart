// Copyright 2020 Liou-Jia-Hao. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
library date_time_field;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateEditingController extends ChangeNotifier {
  DateTime? _date;
  DateFormat? _format;
  DateFormat get format => _format ?? DateFormat('yyyy/MM/dd');
  DateTime? _initialDate;
  DateTime get initialDate => _initialDate ?? DateTime.now();
  DateTime? _firstDate;
  DateTime get firstDate => _firstDate ?? DateTime(2000);
  DateTime? _lastDate;
  DateTime get lastDate => _lastDate ?? DateTime(2100);

  late TextEditingController textController;
  DateTime? get date => _date;
  String get _text => _date == null ? '' : format.format(_date!);
  set date(DateTime? date) {
    _date = date;
    textController.text = _text;
    notifyListeners();
  }

  DateEditingController({
    DateTime? date,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateFormat? format,
  }) {
    _date = date;
    _format = format;
    _initialDate = initialDate;
    _firstDate = firstDate;
    _lastDate = lastDate;
    textController = TextEditingController(text: _text);
  }
  clear() {
    _date = null;
    textController.text = '';
    notifyListeners();
  }

  @override
  dispose() {
    textController.dispose();
    super.dispose();
  }
}

class DateTimeField extends StatefulWidget {
  const DateTimeField({
    Key? key,
    this.decoration,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  final InputDecoration? decoration;
  final void Function(DateTime)? onChanged;
  final DateEditingController controller;
  @override
  _DateTimeFieldState createState() => _DateTimeFieldState();
}

class _DateTimeFieldState extends State<DateTimeField> {
  late TextEditingController textController;
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.none,
      controller: widget.controller.textController,
      onTap: () {
        _selectDate(context);
      },
      decoration: widget.decoration,
    );
  }

  _selectDate(BuildContext context) async {
    final newSelectedDate = await showDatePicker(
      context: context,
      initialDate: widget.controller.initialDate,
      firstDate: widget.controller.firstDate,
      lastDate: widget.controller.lastDate,
    );
    if (newSelectedDate == null) return;
    widget.controller.date = newSelectedDate;
    if (widget.onChanged == null) return;
    widget.onChanged!(newSelectedDate);
  }
}
