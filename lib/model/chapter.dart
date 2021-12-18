import 'package:hive/hive.dart';

part 'chapter.g.dart';

/// We can't add a reference to Manga here because Hive doesn't support circular references.
/// "Objects are not allowed to contain cycles. Hive will not detect them and storing will result in an infinite loop."
/// https://docs.hivedb.dev/#/more/limitations

@HiveType(typeId: 2)
class Chapter {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<String> imagesPath;

  Chapter(this.name, this.imagesPath);
}
