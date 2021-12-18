import 'package:cross_reader/model/chapter.dart';
import 'package:hive/hive.dart';

part 'manga.g.dart';

@HiveType(typeId: 1)
class Manga {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Chapter> chapters;
  @HiveField(2)
  final String onDevicePath;

  Manga(
      {required this.name, required this.chapters, required this.onDevicePath});
}
