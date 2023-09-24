import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Module 7 Assignment',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final _productList = [
    ProductItem(name: "Apple", price: 20),
    ProductItem(name: "Banana", price: 12.99),
    ProductItem(name: "Orange", price: 20),
    ProductItem(name: "Strawberry", price: 18.99),
    ProductItem(name: "TV", price: 299.99),
    ProductItem(name: "Book", price: 20),
    ProductItem(name: "Charger", price: 9.99),
  ];

  final Set<ProductItem> _totalUniqueProduct = {};

  void _handleCount(int index) {
    if (_productList[index].quantity < 5) {
      _productList[index].quantity++;
      _totalUniqueProduct.add(_productList[index]);
      setState(() {});
    }
    if (_productList[index].quantity == 5) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Congratulatioins!"),
          content: Text("You've bought 5 ${_productList[index].name}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _productList.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _productList[index].name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text("Price: ${_productList[index].price}"),
                ],
              ),
              Column(
                children: [
                  Text("Counts: ${_productList[index].quantity}"),
                  ElevatedButton(
                    onPressed: () => _handleCount(index),
                    child: const Text("Buy Now"),
                  ),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const Divider(height: 20),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade900,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(
                totalProduct: _totalUniqueProduct.length,
              ),
            ),
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class ProductItem {
  final String name;
  final double price;
  int quantity;
  ProductItem({
    required this.name,
    required this.price,
    this.quantity = 0,
  });
}

class CartPage extends StatelessWidget {
  final int totalProduct;
  const CartPage({
    super.key,
    required this.totalProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Center(
        child: Text("Total Products: $totalProduct"),
      ),
    );
  }
}
