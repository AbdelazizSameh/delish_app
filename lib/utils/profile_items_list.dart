import '../models/profile_item_model.dart';
import 'app_assets.dart';

final List<ProfileItemModel> profileItemsData = [
  ProfileItemModel(
    iconAsset: AppAssets.profile,
    text: "My Profile",
    onTap: () {},
  ),
  ProfileItemModel(
    iconAsset: AppAssets.profileOrders,
    text: "My Orders",
    onTap: () {},
  ),
  ProfileItemModel(
    iconAsset: AppAssets.iconDeliver,
    text: "Delivery Address",
    onTap: () {},
  ),
  ProfileItemModel(
    iconAsset: AppAssets.profilePayment,
    text: "Payments Methods",
    onTap: () {},
  ),
  ProfileItemModel(
    iconAsset: AppAssets.profileContactUs,
    text: "Contact Us",
    onTap: () {},
  ),
  ProfileItemModel(
    iconAsset: AppAssets.profileSettings,
    text: "Settings",
    onTap: () {},
  ),
  ProfileItemModel(
    iconAsset: AppAssets.profileHelp,
    text: "Help & FAQ",
    onTap: () {},
  ),
];
