import 'package:flutter/material.dart';
import 'package:web_marketku/controllers/banner_controller.dart';
import 'package:web_marketku/models/category_sub.dart';

import '../models/banner.dart';

class CategorySubWidget extends StatefulWidget {
  const CategorySubWidget({super.key, required this.categorySubData});
  final Future<List<CategorySub>> categorySubData;

  @override
  State<CategorySubWidget> createState() => _CategorySubWidgetState();
}

class _CategorySubWidgetState extends State<CategorySubWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.categorySubData,
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
          final catSub = snapshot.data;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: catSub?.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return Image.network(
                catSub![index].image,
                width: 100,
                height: 100,
              );
            },
          );
        }
      },
    );
  }
}
