import "package:cross_reader/model/chapter.dart";
import "package:hive/hive.dart";

part "manga.g.dart";

/// `Manga` entity
@HiveType(typeId: 1)
class Manga extends HiveObject {
  /// `Manga` entity
  Manga({
    required this.name,
    required this.chapters,
    required this.onDevicePath,
  }) : lastReaded = LastReaded.defaultValue();

  @HiveField(0)

  /// name of the `Manga`
  final String name;

  @HiveField(1)

  /// chapters of the `Manga`
  final List<Chapter> chapters;

  @HiveField(2)

  /// path to the `Manga` data on the device
  final String onDevicePath;

  @HiveField(3)

  /// last readed chapter
  LastReaded lastReaded;
}

/// Represent the last data a user has read
class LastReaded {
  /// Represent the last data a user has read
  const LastReaded({required this.chapterIndex, required this.pageIndex});

  /// default LastReaded value (chapterIndex: 0, pageIndex: 0)
  factory LastReaded.defaultValue() =>
      const LastReaded(chapterIndex: 0, pageIndex: 0);

  /// index of the last readed chapter
  final int chapterIndex;

  /// index of the last readed page
  final int pageIndex;
}
