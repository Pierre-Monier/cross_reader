import "package:cross_reader/model/chapter.dart";
import "package:hive/hive.dart";

part "manga.g.dart";

/// `Manga` entity
@HiveType(typeId: 1)
class Manga {
  /// `Manga` entity
  Manga({
    required this.name,
    required this.chapters,
    required this.onDevicePath,
  });
  @HiveField(0)

  /// name of the `Manga`
  final String name;
  @HiveField(1)

  /// chapters of the `Manga`
  final List<Chapter> chapters;
  @HiveField(2)

  /// path to the `Manga` data on the device
  final String onDevicePath;
}
