import 'package:razorpay_integration/model/products.dart';

class ProductDetails {
  // Private static instance of the class
  static final ProductDetails _instance = ProductDetails._internal();

  // Factory constructor to return the same instance
  factory ProductDetails() {
    return _instance;
  }

  // Private named constructor
  ProductDetails._internal();

  List<Product> products = [
    Product(id: '1', title: 'Wireless Bluetooth Headphones', price: 89),
    Product(id: '2', title: 'Smartphone 128GB', price: 79),
    Product(id: '3', title: '4K Ultra HD Smart TV', price: 10),
    Product(id: '4', title: 'Laptop - Intel Core i7', price: 10),
    Product(id: '5', title: 'Electric Toothbrush', price: 49),
    Product(id: '6', title: 'Fitness Tracker Watch', price: 12),
    Product(id: '7', title: 'Gaming Mouse RGB', price: 45),
    Product(id: '8', title: 'Leather Wallet', price: 40),
    Product(id: '9', title: 'Portable Bluetooth Speaker', price: 55),
    Product(id: '10', title: 'Wireless Charging Pad', price: 35),
  ];

  final List<Product> _cartList = [];

  List<Product> get cartList => _cartList;

  void addToCart(Product product) {
    _cartList.add(product);
  }

  void removeFromCart(Product product) {
    _cartList.remove(product);
  }

  int getTotalPrice() {
    return _cartList.fold(0, (sum, product) => sum + product.price);
  }
}
