import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key, required this.categoryData});
  final Future<List<Category>> categoryData;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.categoryData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${{snapshot.error}}"),
          );
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text("Category is empty"),
          );
        } else {
          final category = snapshot.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: category!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return Image.network(
                    height: 100, width: 100, category[index].image);
              },
            ),
          );
        }
      },
    );
  }
}
