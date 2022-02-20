import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

void main() {
  test('prova', () async {
    bool d = Random().nextBool();
    List<String>? c;

    if (d) {
      c = null;
    } else {
      c = ['a', 'b'];
    }

    var v = c?.length;

    print(v);
    print(d);
  });
}
