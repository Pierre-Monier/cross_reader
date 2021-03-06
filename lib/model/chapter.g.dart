// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChapterAdapter extends TypeAdapter<Chapter> {
  @override
  final int typeId = 2;

  @override
  Chapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chapter(
      fields[0] as String,
      (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Chapter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.pagesPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
