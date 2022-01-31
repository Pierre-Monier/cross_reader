// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_readen.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LastReadedAdapter extends TypeAdapter<LastReaden> {
  @override
  final int typeId = 3;

  @override
  LastReaden read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastReaden(
      chapterIndex: fields[0] as int,
      pageIndex: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LastReaden obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.chapterIndex)
      ..writeByte(1)
      ..write(obj.pageIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastReadedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
