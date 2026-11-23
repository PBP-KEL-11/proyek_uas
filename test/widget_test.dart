import 'package:flutter_test/flutter_test.dart';

import 'package:proyek_uas/main.dart';

void main() {
  testWidgets('Bottom navigation switches between Plant and Kebun',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Plant'), findsWidgets);

    await tester.tap(find.text('Kebun'));
    await tester.pumpAndSettle();

    expect(find.text('Kebun'), findsWidgets);
  });
}
