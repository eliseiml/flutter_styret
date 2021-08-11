import 'package:flutter_test/flutter_test.dart';

void main() {
  List<int> list = [];
  var number = 25;

  group("Testing list operations", () {
    test("List should be empty", () {
      expect(list.isEmpty, true);
    });

    test("Should add number to the list", () {
      list.add(number);
      expect(list.contains(number), true);
    });

    test("Should remove number from the list", () {
      list.remove(number);
      expect(list.contains(number), false);
    });
  });
}
