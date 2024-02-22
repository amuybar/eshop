class Product {
  final int id;
  final String name;
  final double price;
  final String imgurl;
  final String descr;
  final String qnty;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imgurl,
    required this.descr,
    required this.qnty,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ,
      name: json['name'] ?? '',
       price: json['price'] != null ? double.tryParse(json['price'].toString()) ?? 0.0 : 0.0, 
      imgurl: json['imgurl'] ?? '',
      descr: json['description'] ?? '',
      qnty: json['quantity'] ?? '',
    );
  }
}
