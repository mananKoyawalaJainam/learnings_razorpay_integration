import 'package:flutter/material.dart';
import 'package:razorpay_integration/model/products.dart';
import 'package:razorpay_integration/screen/cart_screen.dart';
import 'package:razorpay_integration/controller/product_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Home Page",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: ProductDetails().products.length,
                  itemBuilder: (context, index) {
                    Product product = ProductDetails().products[index];
                    bool isInCart = ProductDetails()
                        .cartList
                        .any((p) => p.id == product.id);
                    return ListTile(
                      title: Text(product.title),
                      trailing: InkWell(
                          onTap: () {
                            setState(() {
                              isInCart
                                  ? ProductDetails().removeFromCart(product)
                                  : ProductDetails().addToCart(product);
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: isInCart
                                  ? Icon(Icons.remove)
                                  : Icon(Icons.add))),
                      leading: Text(
                        "₹${product.price.toString()}",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CartScreen()));
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.amber,
                    child: Text(
                      "Go to Cart",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
