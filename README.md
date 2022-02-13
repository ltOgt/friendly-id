# friendly_id
Human readable ID generator based on [friendly-words](https://github.com/glitchdotcom/friendly-words) by [Glitch](https://github.com/glitchdotcom).

Instead of using IDs like `cf935d30-8744-11ec-adf2-814018f5662b` you might want to have unique Strings that users can actually look at and remember.

Using the `> 4000` words provided by `friendly-words`, you can simply chain them to get quite a few ids:
```
word                      4,000
word-word            16,000,000
word-word-word   64,000,000,000
...
```

# Usage
## Caller managed
```dart
// ! This is not a function provided by the package
int start = foo_get_id_offset_from_storage()

/// Supply the number of IDs already generated
FriendlyId generator = FriendlyId(offset: start);
String id = generator.next();

// ! These are not functions provided by the package
bar_set_id_offset_to_storage(generator.offset);
baz_use_id_somewhere_else(id);
```

## Internally managed
```dart
/// The file can have any ending, but should contain only the following content:
/**
# Friendly Id state file, see https://github.com/ltOgt/friendly-id
1032
*/
/// The first line is a comment (other comments are fine too, but that one is generated automatically)
/// The other line is the number of ids that have been generated already
String idPath = "my/file/path/for/friendly-id.txt"

/// Supply the path to the file that will be used to manage the id offset
/// May throw if multiple `FriendlyId.managed` instances try to use the same file at a time
FriendlyId generator = FriendlyId.managed(path: idPath, autoStore: false, keepOpen: true);
String id = generator.next();

/// Will be called after every `generator.next()` if `autoStore: true`.
generator.store();

/// Needs to be called iff `keepOpen: true`.
/// Only then will the `idPath` file be closed.
/// Iff `keepOpen: false`, the generator will open and close the file on every write
generator.dispose();
```