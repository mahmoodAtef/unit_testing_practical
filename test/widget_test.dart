// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:unit_testing_practical/main.dart';

void main() {
  group("Testing all counter functions", () {
    Counter counter = Counter();
    test("test initial val", () {
      expect(counter.count, 0);
    });
    test("Test increment of Counter :", () {
      counter.increment();
      expect(counter.count, 1);
    });
    test("Test dec of counter", () {
      counter.decrement();
      expect(counter.count, 0);
    });
  });
}
