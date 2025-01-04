import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_marketku/controllers/category_controller.dart';
import 'package:web_marketku/models/category_sub.dart';
import 'package:web_marketku/widgets/category_sub_widget.dart';
import 'package:web_marketku/widgets/category_widget.dart';

import '../../controllers/category_sub_controller.dart';
import '../../models/category.dart';

class CategoriesSubScreen extends StatefulWidget {
  static const String id = "\categorysub";
  const CategoriesSubScreen({super.key});

  @override
  State<CategoriesSubScreen> createState() => _CategoriesSubScreenState();
}

class _CategoriesSubScreenState extends State<CategoriesSubScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String title;
  late Future<List<Category>> categoryData;
  late Future<List<CategorySub>> categorySubData;
  late Category? selectedCategory;
  final CategoryController _categoryController = CategoryController();
  final CategorySubController _categorySubController = CategorySubController();

  dynamic image;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
      });
    }
  }

  saveSubCategory() async {
    if (_formKey.currentState!.validate()) {
      if (selectedCategory != null) {
        await _categorySubController.uploadCategorySub(
          context: context,
          categoryId: selectedCategory!.id,
          categoryName: selectedCategory!.name,
          image: image,
          subCategoryName: title,
          onSuccess: () {
            Get.snackbar("Success", "Upload category sub success!");
          },
        );

        setState(() {
          _formKey.currentState!.reset();
          image = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    categoryData = _categoryController.loadCategory();
    categorySubData = _categorySubController.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Categories Sub",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: const Divider(
                  color: Colors.grey,
                ),
              ),
              CategoryWidget(
                categoryData: categoryData,
                isNotSub: false,
                onCategorySelect: (categorySelected) {
                  selectedCategory = categorySelected;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 500,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Title cannot be empty";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(
                    label: Text('Title'),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.blueAccent, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Choose Image:'),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: image != null
                          ? Image.memory(image)
                          : const Text(
                              "Select image",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: const Text(
                      "+ Add image",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  saveSubCategory();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              CategorySubWidget(categorySubData: categorySubData)
            ],
          ),
        ),
      ),
    );
  }
}
