import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:delish/Screens/order_screen/order_screen.dart';
import 'package:delish/models/items_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Services/firebase/Addfunctions/Addfunctions.dart';
import '../../models/order.dart';
import '../../widgets/Global/restaurant_and_food_header.dart';
import '../../widgets/food_details_screeen_widgets/food_details_body.dart';
import '../../widgets/food_details_screeen_widgets/footer.dart';

class FoodDetailsView extends StatefulWidget {
  final ItemModel food;
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
            RestaurantAndFoodHeader(image: food.image),

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
          order: Order(
            restaurantId: food.restaurantId,
            name: food.name,
            image: food.image,
            quantity: quantity,
            totalPrice: (food.price * quantity).toDouble(),
            createdAt: Timestamp.now(),
            idForSearch: food.id,
          ),

          onAdd: () => setState(() => quantity++),

          onRemove: () => setState(() {
            if (quantity > 1) quantity--;
          }),

          onAddToOrder: () async {
            final order = Order(
              id: food.id,
              restaurantId: food.restaurantId,
              name: food.name,
              image: food.image,
              quantity: quantity,
              totalPrice: (food.price * quantity).toDouble(),
              createdAt: Timestamp.now(),
              idForSearch: food.id,
            );

            try {
              final DocumentReference doc = await FirestoreService().addOrder(
                userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                restaurantId: order.restaurantId,
                idForSearch: order.idForSearch,
                totalPrice: order.totalPrice,
                quantity: quantity,
                name: order.name,
                imageUrl: order.image,
              );

              log("Order added successfully with ID: ${doc.id}");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderScreen(orderId: doc.id)),
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
