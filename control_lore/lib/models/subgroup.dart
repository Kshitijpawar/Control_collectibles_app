import 'item.dart';

class Subgroup {
  final String title;
  final List<Item> items;
  Subgroup({required this.title, required this.items});

  factory Subgroup.fromJson(List<dynamic> jsonValue, String jsonKey) {
    return Subgroup(
        title: jsonKey,
        items: jsonValue.map((item) {
          return Item.fromJson(item);
        }).toList());
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'items': items.map((e) => e.toJson()).toList()};
  }

  @override
  String toString() => '\nSubgroup:$title with items: \n \t $items';
}
