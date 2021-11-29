import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter.g.dart';

/// We can't add a reference to Manga here because Hive doesn't support circular references.
/// "Objects are not allowed to contain cycles. Hive will not detect them and storing will result in an infinite loop."
/// https://docs.hivedb.dev/#/more/limitations

@JsonSerializable()
@HiveType(typeId: 2)
class Chapter {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final List<String> imagesPath;

  Chapter(this.name, this.imagesPath);

  /// Connect the generated [_$ChapterFromJson] function to the `fromJson`
  /// factory.
  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  /// Connect the generated [_$ChapterToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}
