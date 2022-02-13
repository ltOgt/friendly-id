import 'package:friendly_id/src/constants.dart';

/// Uses [words] from friendly-words to generate a human readable id.
/// up until [words.length], a single word is returned.
/// After that more words are added as needed:
/// ```
/// w_1,     ..., w_n,
/// w_1-w_1, ..., w_1-w_n,
/// w_2-w_1, ..., w_2-w_n,
/// ...
/// w_n-w_1, ..., w_n-w_n,
/// ...
/// ```
class FriendlyId {
  int _offset;
  int get offset => _offset;

  FriendlyId({
    required int offset,
  }) : _offset = offset;

  String next() {
    int __offset = _offset++;
    if (__offset < wordCount) return words[__offset];

    final indexes = IndexHelper.index(__offset, wordCount);
    return indexes.map((e) => words[e]).join("-");
  }
}

class IndexHelper {
  /// Excel-Like index => index split list
  /// § (26,26) => [0,0] => "AA"
  static List<int> index(int value, int ceil) {
    if (value < 0) return [];
    return [...index((value / ceil).floor() - 1, ceil), value % ceil];
  }
}
