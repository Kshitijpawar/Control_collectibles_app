class Item {
  String itemName;
  String itemUrl;
  String itemText;
  String itemImageUrl;
  Item(
      {required this.itemName,
      required this.itemUrl,
      required this.itemText,
      required this.itemImageUrl});
  factory Item.fromJson(Map json) {
    return Item(
      itemName: json["item_name"],
      itemUrl: json["item_url"],
      itemText: json["item_text"],
      itemImageUrl: json["item_image_src"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemUrl': itemUrl,
      'itemImageUrl': itemImageUrl,
      'itemText': itemText
    };
  }

  @override
  String toString() => 'Itemname :$itemName\n';
}
