import 'package:flutter/material.dart';
import 'package:web_marketku/controllers/banner_controller.dart';

import '../models/banner.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key, required this.bannerData});
  final Future<List<BannerModel>> bannerData;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.bannerData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text("Banners is empty"),
          );
        } else {
          final banners = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: banners?.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return Image.network(
                  banners![index].image,
                  width: 100,
                  height: 100,
                );
              },
            ),
          );
        }
      },
    );
  }
}
