import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otp/main.dart';

void main() {

  group('First screen tests', () {
    testWidgets('init test',
      (widgetTester) async {
        await widgetTester.pumpWidget(MyApp());

        final inputField = find.byType(TextFormField);
        final submitButton = find.text("Submit");

        expect(inputField, findsOneWidget);
        expect(submitButton, findsOneWidget);
      }
    );

    testWidgets('submit a word',
      (widgetTester) async {
        await widgetTester.pumpWidget(MyApp());

        final inputField = find.byType(TextFormField);
        final submitButton = find.text("Submit");

        await widgetTester.enterText(inputField, 'test');
        await widgetTester.tap(submitButton);

        await widgetTester.pump();

        //final richText = find.byKey(const Key('RichTextKey'));

        expect(find.byWidgetPredicate((widget) => widget is RichText && widget.text.visitChildren((span) => span.toPlainText() == 'test\n')), findsOneWidget);
      }
    );

    testWidgets('submit many words',
      (widgetTester) async {
        await widgetTester.pumpWidget(MyApp());

        final inputField = find.byType(TextFormField);
        final submitButton = find.text("Submit");

        await widgetTester.enterText(inputField, 'first');
        await widgetTester.tap(submitButton);
        await widgetTester.pump();
        await widgetTester.enterText(inputField, 'second');
        await widgetTester.tap(submitButton);
        await widgetTester.pump();

        //final richText = find.byKey(const Key('RichTextKey'));

        //expect(find.byType(RichText), findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is RichText && widget.text.visitChildren((span) => span.toPlainText() == "second\n" || span.toPlainText() == "first\n")), findsOneWidget);
      }
    );

    testWidgets('submit exsist words',
      (widgetTester) async {
        await widgetTester.pumpWidget(MyApp());

        final inputField = find.byType(TextFormField);
        final submitButton = find.text("Submit");

        await widgetTester.enterText(inputField, 'first');
        await widgetTester.tap(submitButton);
        await widgetTester.pump();
        await widgetTester.enterText(inputField, 'first');
        await widgetTester.tap(submitButton);
        await widgetTester.pump();

        //final richText = find.byKey(const Key('RichTextKey'));

        //expect(find.byType(RichText), findsOneWidget);
        expect(find.byWidgetPredicate((widget) => widget is RichText && widget.text.visitChildren((span) => span.toPlainText() == "first\n" || span.toPlainText() == "first (wrong)\n")), findsOneWidget);
      }
    );

    testWidgets('input wrong character',
      (widgetTester) async {
        await widgetTester.pumpWidget(MyApp());

        final inputField = find.byType(TextFormField);

        await widgetTester.enterText(inputField, 'test123');
        await widgetTester.pump();

        expect(find.text('test'), findsOneWidget);
        expect(find.text('test123'), findsNothing);
      }
    );

    testWidgets('input long word',
      (widgetTester) async {
        await widgetTester.pumpWidget(MyApp());

        final inputField = find.byType(TextFormField);

        await widgetTester.enterText(inputField, 'pneumonoultramicroscopicsilicovolcanoconiosisasd');
        await widgetTester.pump();

        expect(find.text('pneumonoultramicroscopicsilicovolcanoconiosisasd'), findsOneWidget);
        expect(find.text('The given word is too long!'), findsOneWidget);
      }
    );
  });

  group("Second screen test", () {

    _setUpScreen(WidgetTester tester, String a, String b) async {
      await tester.pumpWidget(MyApp());

      final inputField = find.byType(TextFormField);
      final submitButton = find.text("Submit");

      await tester.enterText(inputField, a);
      await tester.tap(submitButton);
      await tester.pump();
      await tester.enterText(inputField, b);
      await tester.tap(submitButton);
      await tester.pump();

      final tabButton = find.byIcon(Icons.credit_score);
      await tester.tap(tabButton);
      await tester.pumpAndSettle();

    }

    testWidgets('score test',
      (widgetTester) async {
          const String a = "firstdasdff";
          const String b = "second";
          await _setUpScreen(widgetTester, a, b);

          const length = a.length + b.length;

          expect(find.text(length.toString()), findsOneWidget);
      });

      testWidgets('list test',
        (widgetTester) async {
          const String a = "first";
          const String b = "second";
          await _setUpScreen(widgetTester, a, b);

          expect(find.text(a), findsOneWidget);
          expect(find.text(b), findsOneWidget);
          expect(find.text(a.length.toString()), findsWidgets);
          expect(find.text(b.length.toString()), findsWidgets);
        });

      testWidgets('exsist word list test',
        (widgetTester) async {
          const String a = "first";
          const String b = "first";
          await _setUpScreen(widgetTester, a, b);

          expect(find.text(a), findsOneWidget);
          expect(find.text(a.length.toString()), findsNWidgets(2));
        });
  });
}