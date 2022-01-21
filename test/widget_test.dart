// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:assemblyf_quizz/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:assemblyf_quizz/main.dart';

void main() {
  group("quizzes page", () {
    testWidgets('should have a list view for the quizzes (mobile resolution)',
        (WidgetTester tester) async {
      double screenHeight =
          MediaQueryData.fromWindow(tester.binding.window).size.height;
      double screenWidth = 576 - (16 * 2);

      tester.binding.window.physicalSizeTestValue =
          Size(screenWidth, screenHeight);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);

      await tester.pumpWidget(const QuizzApp());

      // Verify that a list view exists if size is less than 576.
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('should have a grid view for the quizzes (tablet+ resolution)',
        (WidgetTester tester) async {
      await tester.pumpWidget(const QuizzApp());

      // Verify that a grid view exists if size is greater than or equal to 576.
      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });
  });
}
