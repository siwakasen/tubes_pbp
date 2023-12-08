import 'dart:convert';

class Item {
  int id;
  String name;
  int price;
  String photo;
  String size;
  int id_type;

  Item(
      {this.id = 0,
      required this.name,
      required this.price,
      required this.photo,
      required this.size,
      required this.id_type});

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        photo: json['photo'],
        size: json['size'],
        id_type: json['id_type'],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'photo': photo,
        'size': size,
        'id_type': id_type,
      };

  printPesanan() {
    print("id: " + id.toString());
    print("name: " + name);
    print("price: " + price.toString());
    print("photo: " + photo);
    print("size: " + size);
    print("id_type: " + id_type.toString());
  }

  Item getIdBySize(List<Item> list, String name, String size) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].name == name && list[i].size == size) {
        return list[i];
      }
    }
    return Item(name: '', price: 0, photo: '', size: '', id_type: -1);
  }

  bool isSamePesanan(List<Item> list, int id) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return true;
      }
    }
    return false;
  }
}
