class Payload {
  final String type;
  final String text;
  Payload({required this.type, required this.text});

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      type: json["type"] as String,
      text: json["text"] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "text": text,
    };
  }
}

class BlobData {
  final String type;
  final String link;
  BlobData({
    required this.type,
    required this.link,
  });

  factory BlobData.fromJson(Map<String, dynamic> json) {
    return BlobData(
      type: json["type"] as String,
      link: json["link"] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "text": link,
    };
  }
}

class Item {
  final String itemName;
  final String itemUrl;
  final Payload payload;
  final BlobData? blob;
  Item({
    required this.itemName,
    required this.itemUrl,
    required this.payload,
    this.blob,
  });
  factory Item.fromJson(Map<String, dynamic> json) {
    final blobJson = json["blob"] as Map<String, dynamic>?;

    return Item(
      itemName: json["title"] as String,
      itemUrl: json["uri"],
      payload: Payload.fromJson(
        json["payload"] as Map<String, dynamic>,
      ),
      blob: blobJson != null && blobJson.isNotEmpty
          ? BlobData.fromJson(blobJson)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemName': itemName,
      'itemUrl': itemUrl,
      "payload": payload.toJson(),
      "blob": blob?.toJson() ?? {},
    };
  }

  @override
  String toString() => 'Itemname :$itemName\n';
}
