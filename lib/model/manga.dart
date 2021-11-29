import 'package:cross_reader/model/chapter.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Manga {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<Chapter> chapters;

  Manga(this.name, this.chapters);

  /// Connect the generated [_$MangaFromJson] function to the `fromJson`
  /// factory.
  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  /// Connect the generated [_$MangaToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MangaToJson(this);
}
