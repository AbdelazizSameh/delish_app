import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Services/firebase/Addfunctions/Addfunctions.dart';
import '../../models/food_item.dart';
import '../../models/order.dart';
import '../../widgets/Global/restaurant_and_food_header.dart';
import '../../widgets/food_details_screeen_widgets/food_details_body.dart';
import '../../widgets/food_details_screeen_widgets/footer.dart';

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
    final foodItem = widget.food;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             RestaurantAndFoodHeader(image: foodItem.image),

            FoodDetailsBody(
              food: foodItem,
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
          order: Order(
            restaurantId: food.restaurantId,
            name: food.name,
            image: food.image,
            quantity: quantity,
            totalPrice: (food.price * quantity).toDouble(),
            createdAt: Timestamp.now(),
          ),

          onAdd: () => setState(() => quantity++),

          onRemove: () => setState(() {
            if (quantity > 1) quantity--;
          }),

          onAddToOrder: () async {
            final order = Order(
              restaurantId: food.restaurantId,
              name: food.name,
              image: food.image,
              quantity: quantity,
              totalPrice: (food.price * quantity).toDouble(),
              createdAt: Timestamp.now(),
            );

            try {
              FirestoreService().addOrder(
                userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                restaurantId: order.restaurantId,
                totalPrice: order.totalPrice,
                quantity: quantity,
                name: order.name,
              );
            } catch (e) {
              log(e.toString());
            }
          },
        ),
      ),
    );
  }
}
