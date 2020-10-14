import 'package:flutter_test/flutter_test.dart';

import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Should display the main image when Dashboard is opended',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });
  testWidgets('Should display the first feature when the dashboard is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));
    final firstFeature = find.byType(FeatureItem);
    expect(firstFeature, findsWidgets);
  });
}
