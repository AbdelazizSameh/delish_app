// lib/screens/add_balban_restaurant.dart
import 'package:delish/Services/firebase/Addfunctions/Addfunctions.dart';
import 'package:flutter/material.dart';
class AddBalbanRestaurant extends StatelessWidget {
  final FirestoreService firestore = FirestoreService();

  AddBalbanRestaurant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة: بلبن (11 تصنيف)'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHBHHQJtMf4EikCJppU7u94NNoGb-bIsQUEw&s",
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.cake, size: 100),
              ),
              const SizedBox(height: 20),
              const Text(
                'هيضيف:\n'
                '• مطعم: بلبن\n'
                '• 11 تصنيف (تم حذف شو كيز)\n'
                '• 25 عنصر (بدون شو كيز)\n'
                '• تقييم: 9.0\n'
                '• كل الصور مُحدثة',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => _addBalbanData(context),
                icon: const Icon(Icons.cake, color: Colors.white),
                label: const Text('إضافة بلبن - 25 عنصر'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addBalbanData(BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(const SnackBar(content: Text('جاري إضافة بلبن (25 عنصر)...')));

    try {
      final restaurantRef = await firestore.addRestaurant(
        name: "بلبن",
        imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHBHHQJtMf4EikCJppU7u94NNoGb-bIsQUEw&s",
        isFast: false,
        rating: 9.0,
      );

      final restaurantId = restaurantRef.id;

      // 1. فزعة الشيكولا
      await _addCategoryWithItems(restaurantId, "فزعة الشيكولا", [
        {'name': 'فزعة الشيكولا (صغير)', 'price': 125.0, 'image': 'https://qrcgcustomers.s3-eu-west-1.amazonaws.com/account24888462/55298112_1.png?0.423043208210231', 'popular': true},
        {'name': 'فزعة الشيكولا (كبير)', 'price': 300.0, 'image': 'https://qrcgcustomers.s3-eu-west-1.amazonaws.com/account24888462/55298112_1.png?0.423043208210231', 'popular': true},
      ]);

      // 2. فزعة الشيكولا جولد
      await _addCategoryWithItems(restaurantId, "فزعة الشيكولا جولد", [
        {'name': 'فزعة الشيكولا جولد', 'price': 300.0, 'image': 'https://qrcgcustomers.s3-eu-west-1.amazonaws.com/account24888462/55377271_1.png?0.4738868738382359', 'popular': true},
      ]);

      // 3. كشري
      await _addCategoryWithItems(restaurantId, "كشري", [
        {'name': 'كشري مانجو', 'price': 75.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8NTDBXd5cDAHwOdzoFZs3AQ7vQ0X40E715w&s', 'popular': true},
        {'name': 'كشري بستاشيو', 'price': 85.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuSVZo-oEjiS0NJqfty0p4Y04FoJ44B160rw&s', 'popular': true},
        {'name': 'كشري شيكولا', 'price': 70.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSk4XqC_TVnQl6UzBNGY06atOe4CnZgKDnKfA&s', 'popular': false},
        {'name': 'كشري اوريو', 'price': 85.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwlIEHhnJ9UJ-L5Ig-JSZaMlmnGCnk_1fjjw&s', 'popular': true},
      ]);

      // 4. البامبوظة (8 أصناف)
      await _addCategoryWithItems(restaurantId, "البامبوظة", [
        {'name': 'بامبوظة عادية (صغير)', 'price': 65.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5aBHh1KOMoj3nMYVwq0LTNXIflBnqxMGpgQ&s', 'popular': false},
        {'name': 'بامبوظة عادية (كبير)', 'price': 105.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5aBHh1KOMoj3nMYVwq0LTNXIflBnqxMGpgQ&s', 'popular': true},
        {'name': 'بامبوظة مانجو (صغير)', 'price': 65.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5aBHh1KOMoj3nMYVwq0LTNXIflBnqxMGpgQ&s', 'popular': false},
        {'name': 'بامبوظة مانجو (كبير)', 'price': 105.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5aBHh1KOMoj3nMYVwq0LTNXIflBnqxMGpgQ&s', 'popular': true},
        {'name': 'بامبوظة مكسرات (صغير)', 'price': 65.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_BmPVmsrr4qgARTdHXkRNSfFMqLEXcxudcw&s', 'popular': false},
        {'name': 'بامبوظة مكسرات (كبير)', 'price': 105.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_BmPVmsrr4qgARTdHXkRNSfFMqLEXcxudcw&s', 'popular': true},
        {'name': 'بامبوظة بندق (صغير)', 'price': 65.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrAko8eByo-3Qip-G29cIzYGp35TXO_3nJAA&s', 'popular': false},
        {'name': 'بامبوظة بندق (كبير)', 'price': 105.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTrAko8eByo-3Qip-G29cIzYGp35TXO_3nJAA&s', 'popular': true},
      ]);

      // 5. هوبا تيتا مامبو
      await _addCategoryWithItems(restaurantId, "هوبا تيتا مامبو", [
        {'name': 'هوبا تيتا مامبو (مانجو)', 'price': 130.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR33ze52KkxHYxS8euhm7kB_j4uR1v3kJPc1g&s', 'popular': true},
        {'name': 'هوبا تيتا مامبو (فراولة بيستاشيو)', 'price': 130.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKyJzoLFGqoH-AbonrN03y-KO6Hld48pSAZQ&s', 'popular': true},
        {'name': 'هوبا تيتا مامبو (فراولة شيكولا)', 'price': 130.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTenyp9C_zDWjkOTsfdTzf-l9H-hM2bpQgpgA&s', 'popular': true},
      ]);

      // 6. اللؤة
      await _addCategoryWithItems(restaurantId, "اللؤة", [
        {'name': 'اللؤة (فراولة)', 'price': 85.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGjM790Wj80tUcb6bLt1lr75cuhGv9wfUfDg&s', 'popular': true},
        {'name': 'اللؤة (مانجو)', 'price': 85.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqHVk_Uqz9PR3dCuXK3csaUN1HUpcd6RJcmA&s', 'popular': true},
        {'name': 'اللؤة (بيستاشيو)', 'price': 85.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqHVk_Uqz9PR3dCuXK3csaUN1HUpcd6RJcmA&s', 'popular': true},
      ]);

      // 7. كريم دي لا كريم
      await _addCategoryWithItems(restaurantId, "كريم دي لا كريم", [
        {'name': 'كريم دي لا كريم', 'price': 130.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRViwIyRssIrQr_h1e61MfqlF6nvJDzcrvxcQ&s', 'popular': true},
      ]);

      // 8. دباديبو
      await _addCategoryWithItems(restaurantId, "دباديبو", [
        {'name': 'دباديبو (صغير)', 'price': 75.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPbwu-MdFsB-WQi6FOOzl5LxAuMnR8ql6jKg&s', 'popular': false},
        {'name': 'دباديبو (كبير)', 'price': 195.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPbwu-MdFsB-WQi6FOOzl5LxAuMnR8ql6jKg&s', 'popular': true},
      ]);

      // 9. الشوكو برجر
      await _addCategoryWithItems(restaurantId, "الشوكو برجر", [
        {'name': 'الشوكو برجر', 'price': 125.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNSwxidkyrsfTH-uOawuSbCa7vdeaBfU8GDw&s', 'popular': true},
      ]);

      // 10. كريب ماجنم دبي
      await _addCategoryWithItems(restaurantId, "كريب ماجنم دبي", [
        {'name': 'كريب ماجنم دبي', 'price': 120.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSOlpjwVU2qBGrPhG6PrnIVh3dhT1E8MUX1uw&s', 'popular': true},
      ]);

      // 11. كبسة
      await _addCategoryWithItems(restaurantId, "كبسة", [
        {'name': 'كبسة (صغير)', 'price': 75.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTV0wB_JQL5CIvXCxs9Qcf-QuAp1_wvXL6GiA&s', 'popular': false},
        {'name': 'كبسة (كبير)', 'price': 300.0, 'image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRR0zdhnT7CP_HaeyxVoPMoq9wNqwtDDtFgrA&s', 'popular': true},
      ]);

      // تم حذف "شو كيز" تمامًا

      scaffold.hideCurrentSnackBar();
      scaffold.showSnackBar(SnackBar(
        content: const Text('تم إضافة مطعم "بلبن" مع 11 تصنيف و25 عنصر بنجاح! (بدون شو كيز)'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      scaffold.hideCurrentSnackBar();
      scaffold.showSnackBar(SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red));
    }
  }

  Future<void> _addCategoryWithItems(String restaurantId, String catName, List<Map<String, dynamic>> items) async {
    final catRef = await firestore.addCategory(
      restaurantId: restaurantId,
      name: catName,
      imageUrl: items.first['image'],
    );

    for (var item in items) {
      await firestore.addItem(
        restaurantId: restaurantId,
        categoryId: catRef.id,
        name: item['name'],
        description: '',
        price: item['price'],
        discount: 0.0,
        isPopular: item['popular'],
        imageUrl: item['image'],
      );
    }
  }
}