import 'dart:convert';

class Response {
  int totalCount;
  bool incompleteResults;
  List<Item> items;

  Response({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    totalCount: json["total_count"],
    incompleteResults: json["incomplete_results"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "incomplete_results": incompleteResults,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  int id;
  String name;
  String? description;

  Item({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
  };

  static String encode(List<Item> items) => json.encode(
    items.map<Map<String, dynamic>>((item) => item.toJson())
        .toList(),
  );

  static List<Item> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Item>((item) => Item.fromJson(item))
          .toList();

  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description}';
  }
}