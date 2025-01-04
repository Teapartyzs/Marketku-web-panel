import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget(
      {super.key,
      required this.categoryData,
      required this.isNotSub,
      required this.onCategorySelect});
  final Future<List<Category>> categoryData;
  final bool isNotSub;
  final void Function(Category?) onCategorySelect;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Category? selectedCategory;
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
          return widget.isNotSub
              ? GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shrinkWrap: true,
                  itemCount: category!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (context, index) {
                    return Image.network(
                        height: 100, width: 100, category[index].image);
                  },
                )
              : DropdownButton<Category>(
                  value: selectedCategory,
                  hint: selectedCategory == null
                      ? const Text("Select category")
                      : Text(selectedCategory!.name),
                  items: snapshot.data!.map(
                    (Category data) {
                      return DropdownMenuItem(
                        value: data,
                        child: Text(data.name),
                      );
                    },
                  ).toList(),
                  onChanged: (value) {
                    setState(
                      () {
                        selectedCategory = value;
                        widget.onCategorySelect(value);
                      },
                    );
                  },
                );
        }
      },
    );
  }
}
