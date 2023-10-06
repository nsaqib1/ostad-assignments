import 'package:flutter/material.dart';
import '../widgets/bottom_section.dart';
import '../widgets/cart_item.dart';
import 'package:module9_assignment/product_model.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<ProductModel> _productList = [
    ProductModel(
      imageUrl: "assets/1.jpg",
      name: "Pullover",
      color: "Black",
      size: "L",
      price: 51,
    ),
    ProductModel(
      imageUrl: "assets/2.jpg",
      name: "Tshirt",
      color: "Grey",
      size: "L",
      price: 30,
    ),
    ProductModel(
      imageUrl: "assets/3.jpg",
      name: "Sport Dress",
      color: "Black",
      size: "M",
      price: 43,
    ),
  ];

  void _increaseByOne(int index) {
    _productList[index].qty++;
    _calculateTotalPrice();
    setState(() {});
  }

  void _decreaseByOne(int index) {
    if (_productList[index].qty > 1) {
      _productList[index].qty--;
      _calculateTotalPrice();
      setState(() {});
    }
  }

  void _calculateTotalPrice() {
    _totalPrice = _productList.fold(
      0,
      (sum, element) => sum + (element.price * element.qty),
    );
  }

  double _totalPrice = 0;

  @override
  void initState() {
    _calculateTotalPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Bag",
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return CartItem(
                          index: index,
                          product: _productList[index],
                          decrease: _decreaseByOne,
                          increase: _increaseByOne,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                    ),
                  ),
                  BottomSection(price: _totalPrice),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("My Bag"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: ListView.separated(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return CartItem(
                        index: index,
                        product: _productList[index],
                        decrease: _decreaseByOne,
                        increase: _increaseByOne,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      BottomSection(price: _totalPrice),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
