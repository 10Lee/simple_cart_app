class Airsoft {
  late int id;
  late String name;
  late String image;
  late int price;
  late int qty;

  Airsoft({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.qty,
  });

  factory Airsoft.fromMap(Map<String, dynamic> map) => Airsoft(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        price: map['price'],
        qty: map['qty'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "qty": qty,
      };
}
