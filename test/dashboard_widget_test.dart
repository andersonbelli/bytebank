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
  testWidgets(
      'Should display the transfer feature when the dashboard is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final transferFeatureItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(widget, "Transfer", Icons.monetization_on);
    });
    expect(transferFeatureItem, findsOneWidget);
  });
  testWidgets(
      'Should display the transaction feed feature when the dashboard is opened',
      (tester) async {
    await tester.pumpWidget(MaterialApp(home: Dashboard()));

    final transferFeatureItem = find.byWidgetPredicate((widget) {
      return featureItemMatcher(
          widget, 'Transaction feed', Icons.insert_drive_file);
    });
    expect(transferFeatureItem, findsOneWidget);
  });
}

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon;
  }

  return false;
}
