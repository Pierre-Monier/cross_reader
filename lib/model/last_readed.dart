import "package:hive/hive.dart";

part "last_readed.g.dart";

/// Represent the last data a user has read
@HiveType(typeId: 3)
class LastReaded {
  /// Represent the last data a user has read
  const LastReaded({required this.chapterIndex, required this.pageIndex});

  /// default LastReaded value (chapterIndex: 0, pageIndex: 0)
  factory LastReaded.defaultValue() =>
      const LastReaded(chapterIndex: 0, pageIndex: 0);

  /// index of the last readed chapter
  @HiveField(0)
  final int chapterIndex;

  /// index of the last readed page
  @HiveField(1)
  final int pageIndex;
}
