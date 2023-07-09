import 'package:json_annotation/json_annotation.dart';

part 'api_structs.g.dart';

typedef ID = int;
typedef Price = double;
typedef Name = String;

@JsonSerializable()
class Collection {
  final ID id;
  final Name name;

  Collection(this.id, this.name);

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
}

@JsonSerializable()
class CollectionItem {
  final ID collectionId;
  final ID itemId;

  CollectionItem(this.collectionId, this.itemId);

  factory CollectionItem.fromJson(Map<String, dynamic> json) =>
      _$CollectionItemFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionItemToJson(this);
}

@JsonSerializable()
class Category {
  @JsonKey(includeIfNull: true)
  final ID? id;
  final String name;
  @JsonKey(includeIfNull: true)
  final ID? parentCategory;

  Category(this.id, this.name, this.parentCategory);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Item {
  final ID? id;
  final String name;
  final String? description;
  final ID? categoryId;
  final Price? price;

  Item(this.id, this.name, this.description, this.categoryId, this.price);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}