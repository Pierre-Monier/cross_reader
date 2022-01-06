// GENERATED CODE - DO NOT MODIFY BY HAND

part of "manga.dart";

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaAdapter extends TypeAdapter<Manga> {
  @override
  final int typeId = 1;

  @override
  Manga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Manga(
      name: fields[0] as String,
      chapters: (fields[1] as List).cast<Chapter>(),
      onDevicePath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Manga obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.chapters)
      ..writeByte(2)
      ..write(obj.onDevicePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
