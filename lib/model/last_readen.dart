import "package:hive/hive.dart";

part "last_readen.g.dart";

/// Represent the last data a user has read
@HiveType(typeId: 3)
class LastReaden {
  /// Represent the last data a user has read
  const LastReaden({required this.chapterIndex, required this.pageIndex});

  /// default LastReaden value (chapterIndex: 0, pageIndex: 0)
  factory LastReaden.defaultValue() =>
      const LastReaden(chapterIndex: 0, pageIndex: 0);

  /// index of the last readed chapter
  @HiveField(0)
  final int chapterIndex;

  /// index of the last readed page
  @HiveField(1)
  final int pageIndex;
}
