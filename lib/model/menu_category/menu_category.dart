import 'package:json_annotation/json_annotation.dart';
part 'menu_category.g.dart';

@JsonSerializable()
class MenuCategory {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  MenuCategory({
    this.id,
    this.name
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) => _$MenuCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MenuCategoryToJson(this);
}

