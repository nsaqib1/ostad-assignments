import 'package:flutter/material.dart';

class BottomSection extends StatelessWidget {
  final double price;
  const BottomSection({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Amount:",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "${price.round()}\$",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              backgroundColor: const Color.fromARGB(255, 239, 3, 4),
              padding: const EdgeInsets.all(15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Congratulations! You have pressed the checkout button!",
                  ),
                ),
              );
            },
            child: const Text("Check Out"),
          )
        ],
      ),
    );
  }
}
