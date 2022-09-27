import 'dart:io';
import 'dart:math';

import 'package:friendly_id/friendly_id.dart';

void usage() {
  print("usage: dart genx.dart <min> <max> <count>");
  print("min:   minimum for number range to use");
  print("max:   maximum for number range to use");
  print("count: number of ids to produce");
}

void main(List<String> args) {
  if (args.length != 3) {
    usage();
    exit(1);
  }

  int min, max, count;
  try {
    min = int.parse(args[0]);
    max = int.parse(args[1]);
    count = int.parse(args[2]);

    if (min >= max) {
      print("min has to be smaller than max");
      exit(1);
    }
    if (max - min < count) {
      print("range between min and max has to be larger than count");
      exit(1);
    }
  } catch (_) {
    usage();
    exit(1);
  }

  final random = Random();
  final Set<int> used = {};

  for (int i = 0; i < count; i++) {
    int offset;
    while (true) {
      offset = random.nextInt(max - min) + min;
      if (!used.contains(offset)) {
        used.add(offset);
        break;
      }
    }
    print(FriendlyId(offset: offset).next());
  }
}
