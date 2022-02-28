import 'package:friendly_id/friendly_id.dart';
import 'package:friendly_id/src/constants.dart';
import 'package:test/test.dart';

void main() {
  test('Word Length', () {
    expect(words.length == wordCount, isTrue);
  });

  test('bounds', () {
    expect(
      FriendlyId(offset: 0).next(),
      equals(words.first),
    );
    expect(
      FriendlyId(offset: wordCount - 1).next(),
      equals(words.last),
    );
    expect(
      FriendlyId(offset: wordCount).next(),
      equals(words.first + "-" + words.first),
    );
    expect(
      FriendlyId(offset: wordCount * wordCount).next(),
      equals(words.last + "-" + words.first),
    );
    expect(
      FriendlyId(offset: wordCount + wordCount * wordCount - 1).next(),
      equals(words.last + "-" + words.last),
    );
    expect(
      FriendlyId(offset: wordCount + wordCount * wordCount).next(),
      equals(words.first + "-" + words.first + "-" + words.first),
    );
  });

  test('Offset recovery', () {
    final id = FriendlyId(offset: 0)
      ..next()
      ..next()
      ..next();
    final offset = id.offset;

    expect(offset, equals(3));
    expect(id.next(), equals(FriendlyId(offset: offset).next()));
  });
}
