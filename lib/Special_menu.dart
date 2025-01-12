import 'package:flutter/material.dart';

class SpecialMenu extends StatelessWidget {
  final List<List<String>> d;

  const SpecialMenu(this.d, {super.key});

  @override
  Widget build(BuildContext context) {
    // Determine container height based on the number of items
    double containerHeight;
    if (d.isEmpty) {
      containerHeight = 150; // Height for the "No Special Menu" message
    } else if (d.length <= 2) {
      containerHeight = d.length * 150; // Dynamic height for 1 or 2 items
    } else {
      containerHeight = 300; // Fixed height for 3 or more items
    }

    return SizedBox(
      height: containerHeight,
      child: d.isEmpty
          ? const Center(
        child: Text(
          "No Special Menu Available",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      )
          : ListView.builder(
        physics: d.length > 2
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: d.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Image
                  Image.asset(
                    "assets/mixed grill.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 12),
                  // Text Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Dish Name
                        Text(
                          d[index][0],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Description
                        Text(
                          d[index][1],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          softWrap: true, // Allow text to wrap
                        ),
                        const SizedBox(height: 2),
                        // Price
                        Text(
                          d[index][2],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
