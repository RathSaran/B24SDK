import 'dart:convert';

const products = '''[
        {
          "id": 1,
          "name": "Earthen Bottle",
          "href": "#",
          "price": 1,
          "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-01.jpg",
          "imageAlt": "Tall slender porcelain bottle with natural clay textured body and cork stopper."
        },
        {
          "id": 2,
          "name": "Nomad Tumbler",
          "href": "#",
          "price": 2,
          "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-02.jpg",
          "imageAlt": "Olive drab green insulated bottle with flared screw lid and flat top."
        },
        {
          "id": 3,
          "name": "Focus Paper Refill",
          "href": "#",
          "price": 5,
          "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-03.jpg",
          "imageAlt": "Person using a pen to cross a task off a productivity paper card."
        },
        {
        "id": 4,
        "name": "Machined Mechanical Pencil",
        "href": "#",
        "price": 10,
        "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-04.jpg",
        "imageAlt": "Hand holding black machined steel mechanical pencil with brass tip and top."
    },
    {
        "id": 5,
        "name": "Focus Card Tray",
        "href": "#",
        "price": 15,
        "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-05.jpg",
        "imageAlt": "Hand holding black machined steel mechanical pencil with brass tip and top."
    },
    {
        "id": 6,
        "name": "Focus Multi-Pack",
        "href": "#",
        "price": 20,
        "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-06.jpg",
        "imageAlt": "Hand holding black machined steel mechanical pencil with brass tip and top."
    },
    {
        "id": 7,
        "name": "Brass Scissors",
        "href": "#",
        "price": 50,
        "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-07.jpg",
        "imageAlt": "Hand holding black machined steel mechanical pencil with brass tip and top."
    },
    {
        "id": 8,
        "name": "Focus Carry Pouch",
        "href": "#",
        "price": 100,
        "imageSrc": "https://tailwindui.com/img/ecommerce-images/category-page-04-image-card-08.jpg",
        "imageAlt": "Hand holding black machined steel mechanical pencil with brass tip and top."
    }

  ]''';

class Product {
  int id;
  String name;
  String href;
  double price;
  String imageSrc;
  String imageAlt;

  Product(
      {required this.id,
      required this.name,
      required this.href,
      required this.price,
      required this.imageSrc,
      required this.imageAlt});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      href: json['href'],
      price: json['price'].toDouble(),
      imageSrc: json['imageSrc'],
      imageAlt: json['imageAlt'],
    );
  }

  static List<Product> getProducts() {
    final parsed = json.decode(products).cast<Map<String, dynamic>>();
    var data = parsed.map<Product>((json) => Product.fromJson(json)).toList();
    return data;
  }
}
