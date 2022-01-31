import "package:cross_reader/model/chapter.dart";
import "package:cross_reader/model/last_readen.dart";
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
  }) : lastReaden = LastReaden.defaultValue();

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

  /// last readen chapter
  LastReaden lastReaden;

  /// get the readen % of the `Manga`
  String get readPercentage {
    var total = 0;
    var readen = 0;

    for (final chapter in chapters) {
      total += chapter.pagesPath.length;
    }

    for (var i = 0; i < lastReaden.chapterIndex; i++) {
      readen += chapters[i].pagesPath.length;
    }

    readen += lastReaden.pageIndex + 1;

    return "${readen ~/ total * 100}%";
  }

  /// get the readen % of a given chapter by the adress
  String getChapterReadPercentage(int chapterIndex) {
    if (chapterIndex < lastReaden.chapterIndex) {
      return "100%";
    } else if (chapterIndex > lastReaden.chapterIndex) {
      return "0%";
    }
    // lastReaden.chapterIndex == chapterIndex

    final readen = lastReaden.pageIndex + 1;
    final total = chapters[chapterIndex].pagesPath.length;

    return "${readen ~/ total * 100}%";
  }
}
