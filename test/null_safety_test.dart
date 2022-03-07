import 'package:flutter_test/flutter_test.dart';
import 'dart:math';
import 'dart:developer' as dev;

void main() {
  test('null', () async {
    bool d = Random().nextBool();
    List<String>? c;

    if (d) {
      c = null;
    } else {
      c = ['a', 'b'];
    }

    var v = c?.length;

    dev.log(v.toString());
    dev.log(d.toString());
  });
}
