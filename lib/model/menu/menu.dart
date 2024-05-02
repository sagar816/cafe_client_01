import 'package:json_annotation/json_annotation.dart';
part 'menu.g.dart';

@JsonSerializable()
class Menu {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "price")
  double? price;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "discount")
  bool? discount;

  Menu({
    this.id,
    this.name,
    this.description,
    this.category,
    this.image,
    this.discount,
    this.price,
    this.type,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
