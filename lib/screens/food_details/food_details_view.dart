import 'package:flutter/material.dart';
import '../../models/food_item.dart';
import '../../widgets/food_details_screeen_widgets/food_details_body.dart';
import '../../widgets/food_details_screeen_widgets/footer.dart';
import '../../widgets/shared/restaurant_and_food_header.dart';

class FoodDetailsView extends StatefulWidget {
  final FoodItem food;
  const FoodDetailsView({super.key, required this.food});

  @override
  State<FoodDetailsView> createState() => FoodDetailsViewState();
}

class FoodDetailsViewState extends State<FoodDetailsView> {
  int quantity = 1;
  bool isFavorite = false;
  bool addPackage = false;

  late List<bool> addonSelected;

  @override
  void initState() {
    super.initState();
    addonSelected = List<bool>.filled(widget.food.addons.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RestaurantAndFoodHeader(),

            FoodDetailsBody(
              food: food,
              isFavorite: isFavorite,
              addonSelected: addonSelected,
              addPackage: addPackage,

              onToggleFavorite: () => setState(() {
                isFavorite = !isFavorite;
              }),
              onToggleAddon: (i) => setState(() {
                addonSelected[i] = !addonSelected[i];
              }),
              onTogglePackage: () => setState(() {
                addPackage = !addPackage;
              }),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Footer(
          quantity: quantity,
          onAdd: () => setState(() => quantity++),
          onRemove: () => setState(() {
            if (quantity > 1) quantity--;
          }),
        ),
      ),
    );
  }
}
