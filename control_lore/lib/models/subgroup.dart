import 'item.dart';

class Subgroup {
  final String title;
  final List<Item> items;
  Subgroup({required this.title, required this.items});

  // factory Subgroup.fromJson(Map<String, dynamic> json, String key) {
  //   return Subgroup(
  //       title: key,
  //       items: json[key].map((item) => Item.fromJson(item)).toList());
  // }

  factory Subgroup.fromJson(List<dynamic> jsonValue, String jsonKey) {
    // print("no error");
    return Subgroup(
        title: jsonKey,
        items: jsonValue.map((item) {
          // print("hey $item");
          return Item.fromJson(item);
        }).toList());
  }

  @override
  String toString() => '\nSubgroup:$title with items: \n \t $items';
}
