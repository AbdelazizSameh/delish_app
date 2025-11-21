import 'package:flutter/material.dart';
import 'widgets/food_item.dart';

class FoodDetailsPage extends StatefulWidget {
  final FoodItem food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  int quantity = 1;
  bool isFavorite = false;
  bool addParmesan = false;
  bool addSauce = false;
  bool addPackage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBEFE5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBEFE5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          widget.food.name,
          style: const TextStyle(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main food image
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: widget.food.image.isNotEmpty
                  ? Image.asset(
                      widget.food.image,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey[200],
                      child: const Icon(Icons.fastfood,
                          size: 80, color: Colors.grey),
                    ),
            ),
            const SizedBox(height: 20),
            // Name & favorite row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.food.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => isFavorite = !isFavorite),
                  child: Icon(
                    isFavorite
                        ? Icons.favorite_sharp
                        : Icons.favorite_border_sharp,
                    color: const Color(0xFFFF4400),
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Description
            Text(
              widget.food.description,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            // Price row (left aligned)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '\$${widget.food.price.toStringAsFixed(2)}', // current price
                  style: TextStyle(
                    color: Color(0xFFFF4400),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  // old price = current price + 15% (as discount simulation)
                 '\$${(widget.food.price * 1.15).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
           //Add'ons Section
           if (widget.food.addons.isNotEmpty) ...[
            const Text(
              'Add more',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
           
            const SizedBox(height: 12),
            // List of add-ons
               Column(
              children: widget.food.addons.map((addon) {
              bool selected = false;

                return StatefulBuilder(
                 builder: (context, setStateSB) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
              child: Row(
               children: [
              Image.asset(addon.image, width: 40, height: 40),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  addon.name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                "+\$${addon.price.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => setStateSB(() => selected = !selected),
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFFF4400),
                      width: 2,
                    ),
                  ),
                  child: selected
                      ? Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFF4400),
                              shape: BoxShape.circle,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  ),
 ],
            const SizedBox(height: 20),
            const Text(
              'Package',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),

            // Package option
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF4400).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.inventory_2,
                      color: Color(0xFFFF4400), size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Package box cost',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                const Text('+\$0.50',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () => setState(() => addPackage = !addPackage),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF4400),
                        width: 2,
                      ),
                    ),
                    child: addPackage
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF4400),
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
           const SizedBox(height: 30),
            // Quantity & Add button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Quantity
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE6D5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) setState(() => quantity--);
                        },
                        icon: const Icon(Icons.remove_circle,
                            color: Color(0xFFFF4400)),
                      ),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(Icons.add_circle, color: Color(0xFFFF4400)),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                  ),
                  child: const Text(
                    'Add to order',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
