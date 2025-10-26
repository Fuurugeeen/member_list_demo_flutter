// Member List Demo Flutter widget tests.
//
// Tests for the member list application functionality.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:member_list_demo_flutter/main.dart';

void main() {
  testWidgets('App loads with business theme', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    
    // Wait for initial frame
    await tester.pump();
    
    // Find the MaterialApp to check theme is applied
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    
    // Verify business theme is applied
    expect(app.theme?.useMaterial3, isTrue);
    expect(app.title, equals('Member List Demo'));
  });

  testWidgets('App structure is correct', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pump();

    // Verify app has the expected structure
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
