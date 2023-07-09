// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_structs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      json['id'] as int,
      json['name'] as String,
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CollectionItem _$CollectionItemFromJson(Map<String, dynamic> json) =>
    CollectionItem(
      json['collectionId'] as int,
      json['itemId'] as int,
    );

Map<String, dynamic> _$CollectionItemToJson(CollectionItem instance) =>
    <String, dynamic>{
      'collectionId': instance.collectionId,
      'itemId': instance.itemId,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['id'] as int?,
      json['name'] as String,
      json['parentCategory'] as int?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentCategory': instance.parentCategory,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      json['id'] as int?,
      json['name'] as String,
      json['description'] as String?,
      json['categoryId'] as int?,
      (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'price': instance.price,
    };
