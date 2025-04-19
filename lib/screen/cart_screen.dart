import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_integration/model/products.dart';
import 'package:razorpay_integration/controller/product_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log(">>> Payment Success Called");
    log(">>> response data :: ${response.data}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    log('>>> message :: ${response.message!}');
    log('>>> code :: ${response.code}');
    log('>>> error :: ${response.error}');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log(">>> External Wallet Called Wallet name : ${response.walletName}");
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_msWrDdI2wpXI8F',
      'amount': 1000,
      'name': 'Manan Koyawala',
      'description': 'Payment demo',
      'currency': 'INR',
      'prefill': {
        'contact': '9016391146',
        'email': 'test@razorpay.com',
      },
      'theme': {'color': '#FFCD00'},
      'external': {
        'wallets': ['paytm', 'phonepe']
      },
      'method': {
        'netbanking': true,
        'card': true,
        'wallet': true,
        'upi': true,
        'paylater': false
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log(">>> ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                    ),
                    Text(
                      "Cart Page",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Expanded(
                  child: ProductDetails().cartList.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: ProductDetails().cartList.length,
                          itemBuilder: (context, index) {
                            Product product = ProductDetails().cartList[index];

                            return ListTile(
                              title: Text(product.title),
                              trailing: InkWell(
                                  onTap: () {
                                    setState(() {
                                      ProductDetails().removeFromCart(product);
                                    });
                                  },
                                  child: Icon(Icons.remove)),
                              leading: Text(
                                "₹${product.price.toString()}",
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text("There is noting to show in Cart."),
                        ),
                ),
                SizedBox(height: 16),
                ProductDetails().cartList.isNotEmpty
                    ? Text(
                        'Total amount  ₹ ${ProductDetails().getTotalPrice().toString()}',
                        style: TextStyle(fontSize: 18),
                      )
                    : Container(),
                InkWell(
                  onTap: () {
                    // if (ProductDetails().cartList.isEmpty) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //       content: Text("Please add atleast on item in cart")));
                    //   return;
                    // }
                    openCheckout();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    height: 50,
                    alignment: Alignment.center,
                    width: double.infinity,
                    color: Colors.amber,
                    child: Text(
                      "Checkout",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
