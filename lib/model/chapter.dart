import "package:hive/hive.dart";

part "chapter.g.dart";

/// `Chapter` entity
///
/// We can't add a reference to Manga here because Hive doesn't support
///  circular references.
/// "Objects are not allowed to contain cycles. Hive will not detect them
///  and storing will result in an infinite loop."
/// https://docs.hivedb.dev/#/more/limitations

@HiveType(typeId: 2)
class Chapter {
  /// `Chapter` entity
  Chapter(this.name, this.pagesPath);
  @HiveField(0)

  /// name of the chapter
  final String name;
  @HiveField(1)

  /// pages of the chapter
  final List<String> pagesPath;
}
