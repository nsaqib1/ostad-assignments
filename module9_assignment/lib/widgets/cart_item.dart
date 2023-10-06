import 'package:flutter/material.dart';

import '../product_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required ProductModel product,
    required this.increase,
    required this.decrease,
    required int index,
  })  : _product = product,
        _index = index;

  final ProductModel _product;
  final int _index;
  final Function(int index) increase;
  final Function(int index) decrease;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10),
              ),
              child: Image.asset(
                _product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(Icons.more_vert),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Color:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      Text(_product.color),
                      const SizedBox(width: 10),
                      const Text(
                        "Size:",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(width: 5),
                      Text(_product.size),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FloatingActionButton.small(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 2,
                        onPressed: () => decrease(_index),
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _product.qty.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 5),
                      FloatingActionButton.small(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        elevation: 2,
                        onPressed: () => increase(_index),
                        child: const Icon(Icons.add),
                      ),
                      const Spacer(),
                      Text(
                        "\$${_product.price.round()}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
