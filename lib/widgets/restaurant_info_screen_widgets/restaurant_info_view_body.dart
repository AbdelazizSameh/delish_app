import 'package:delish/models/restaurants_model.dart';
import 'package:flutter/material.dart';
import '../../models/menu_item_model.dart';
import '../../models/food_item.dart';
import '../../screens/food_details/food_details_view.dart';
import 'menu_item_card.dart';
import '../Global/restaurant_and_food_header.dart';
import 'restaurant_info.dart';

class RestaurantInfoViewBody extends StatelessWidget {
  const RestaurantInfoViewBody({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: RestaurantAndFoodHeader(image: restaurantModel.image),
        ),
        SliverToBoxAdapter(child: RestaurantInfo(model: restaurantModel)),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList.separated(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailsView(
                      food: FoodItem(
                        name: "Cheese Burger",
                        image: "assets/images/Breaded chicken.jpg",
                        price: 85.0,
                        oldPrice: 100.0,
                        description:
                            "A delicious beef burger topped with melted cheese, fresh veggies, and our special sauce.",
                        addons: [
                          AddOn(
                            name: "Extra Cheese",
                            price: 10.0,
                            image: "assets/images/Ketchup.jpg",
                          ),
                          AddOn(
                            name: "Spicy Sauce",
                            price: 5.0,
                            image: "assets/images/Ketchup.jpg",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                child: MenuItemCard(index: index + 1, item: menuItems[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0, thickness: 0.5),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
