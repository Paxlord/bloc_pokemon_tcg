// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemontcg_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonCardAdapter extends TypeAdapter<PokemonCard> {
  @override
  final int typeId = 1;

  @override
  PokemonCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonCard(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List).cast<String>(),
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonCard obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.imageUrl_Big)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.types);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
