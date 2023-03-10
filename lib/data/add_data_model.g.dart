// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class adddataAdapter extends TypeAdapter<add_data> {
  @override
  final int typeId = 1;

  @override
  add_data read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return add_data(
      name: fields[0] as String,
      explain: fields[1] as String,
      amount: fields[2] as String,
      how: fields[3] as String,
      time: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, add_data obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.explain)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.how)
      ..writeByte(4)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is adddataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
