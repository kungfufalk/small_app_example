import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_structs.g.dart';

typedef ID = int;
typedef Price = double;
typedef Name = String;
typedef Description = String;

@JsonSerializable()
@immutable
class Collection {
  final ID id;
  final Name name;

  const Collection(this.id, this.name);

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

@JsonSerializable()
@immutable
class CollectionItem {
  final ID collectionId;
  final ID itemId;

  const CollectionItem(this.collectionId, this.itemId);

  factory CollectionItem.fromJson(Map<String, dynamic> json) =>
      _$CollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionItemToJson(this);
}

@JsonSerializable()
@immutable
class Category {
  @JsonKey(includeIfNull: true)
  final ID? id;
  final String name;
  @JsonKey(includeIfNull: true)
  final ID? parentCategory;
  final String? thumbnail;

  const Category(this.id, this.name, this.parentCategory, this.thumbnail);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
@immutable
class Item {
  final ID? id;
  final Name name;
  final Description? description;
  final ID? categoryId;
  final Price? price;

  const Item(this.id, this.name, this.description, this.categoryId, this.price);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
