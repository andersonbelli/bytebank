import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  final mockContactDao = MockContactDao();

  group('When Dashboard is opened', () {
    testWidgets('Should display the main image', (WidgetTester tester) async {
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    });
    testWidgets('Should display the transfer feature', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));

      final transferFeatureItem = find.byWidgetPredicate((widget) {
        return featureItemMatcher(widget, "Transfer", Icons.monetization_on);
      });
      expect(transferFeatureItem, findsOneWidget);
    });
    testWidgets('Should display the transaction feed feature', (tester) async {
      await tester
          .pumpWidget(MaterialApp(home: Dashboard(contactDao: mockContactDao)));

      final transferFeatureItem = find.byWidgetPredicate((widget) {
        return featureItemMatcher(
            widget, 'Transaction feed', Icons.insert_drive_file);
      });
      expect(transferFeatureItem, findsOneWidget);
    });
  });
}
