import 'package:flutter_test/flutter_test.dart';
import '../example/my_app.dart';
import 'package:date_time_field/date_time_field.dart';

void main() {
  testWidgets('Testing instantiate DateTimePicker',
      (WidgetTester tester) async {
    var myWidget = const MyApp();
    await tester.pumpWidget(myWidget);

    expect(
      find.text('2020/01/01'),
      findsOneWidget,
      reason: 'DateTimePicker initial display date not found!',
    );

    var dateTimePicker = find.byType(DateTimeField);
    expect(
      dateTimePicker,
      findsOneWidget,
      reason: 'DateTimeField not found!',
    );

    await tester.tap(dateTimePicker);
    await tester.pumpWidget(myWidget);

    var day = find.text('25');
    expect(
      day,
      findsOneWidget,
      reason: 'DateTimeField day 25 not found!',
    );
    var okBtn = find.text('OK');
    expect(
      okBtn,
      findsOneWidget,
      reason: 'DateTimeField OK button not found!',
    );

    // await tester.tap(day);
    // await tester.tap(okBtn);

    // expect(
    //   find.text('2020/07/25'),
    //   findsOneWidget,
    //   reason: 'DateTimeField new date selected not found on text field!',
    // );

    // await tester.pumpWidget(myWidget);
    // expect(
    //   find.text('2020/07/25'),
    //   findsOneWidget,
    //   reason: 'DateTimePicker new date value not found!',
    // );
  });
}
