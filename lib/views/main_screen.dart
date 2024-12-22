import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_marketku/views/sidebar/banners_screen.dart';
import 'package:web_marketku/views/sidebar/buyers_screen.dart';
import 'package:web_marketku/views/sidebar/categories_screen.dart';
import 'package:web_marketku/views/sidebar/orders_screen.dart';
import 'package:web_marketku/views/sidebar/products_screen.dart';
import 'package:web_marketku/views/sidebar/upload_banner_screen.dart';
import 'package:web_marketku/views/sidebar/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = VendorsScreen();
  screenSelector(item) {
    switch (item.route) {
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = VendorsScreen();
        });
        break;
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = BuyersScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = OrdersScreen();
        });
        break;
      case CategoriesScreen.id:
        setState(() {
          _selectedScreen = CategoriesScreen();
        });
        break;
      case BannersScreen.id:
        setState(() {
          _selectedScreen = BannersScreen();
        });
        break;
      case UploadBannerScreen.id:
        setState(() {
          _selectedScreen = UploadBannerScreen();
        });
        break;
      case ProductsScreen.id:
        setState(() {
          _selectedScreen = ProductsScreen();
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blueAccent,
          title: const Text(
            "Marketku",
            style: TextStyle(color: Colors.white),
          ),
        ),
        sideBar: SideBar(
          header: Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.amber),
            child: const Center(
              child: Text(
                "Multi Vendors Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    letterSpacing: 1,
                    fontSize: 16),
              ),
            ),
          ),
          items: const [
            AdminMenuItem(
                title: "Vendors",
                route: VendorsScreen.id,
                icon: Icons.store_rounded),
            AdminMenuItem(
                title: "Buyers",
                route: BuyersScreen.id,
                icon: CupertinoIcons.person_2),
            AdminMenuItem(
                title: "Orders",
                route: OrdersScreen.id,
                icon: CupertinoIcons.bag),
            AdminMenuItem(
                title: "Categories",
                route: CategoriesScreen.id,
                icon: Icons.category_outlined),
            AdminMenuItem(
                title: "Banners",
                route: BannersScreen.id,
                icon: Icons.branding_watermark),
            AdminMenuItem(
                title: "Upload Banners",
                route: UploadBannerScreen.id,
                icon: CupertinoIcons.add),
            AdminMenuItem(
                title: "Products",
                route: ProductsScreen.id,
                icon: Icons.production_quantity_limits_outlined)
          ],
          selectedRoute: VendorsScreen.id,
          onSelected: (item) => screenSelector(item),
        ),
        body: _selectedScreen);
  }
}
