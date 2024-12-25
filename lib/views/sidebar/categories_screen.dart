import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:web_marketku/controllers/category_controller.dart';

class CategoriesScreen extends StatefulWidget {
  static const String id = '\categories';
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CategoryController categoryController = CategoryController();
  late String title;

  dynamic image;
  dynamic banner;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        image = result.files.first.bytes;
      });
    }
  }

  pickBannerImage() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      setState(() {
        banner = result.files.first.bytes;
      });
    }
  }

  validateForm() async {
    if (_formKey.currentState!.validate()) {
      await categoryController.uploadCategory(
          context: context, name: title, pickImage: image, pickBanner: banner);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              child: const Text(
                "Categories",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: const Divider(
                color: Colors.grey,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 500,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      onChanged: (value) => title = value,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Title cannot be empty!";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        label: Text("Title:"),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
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
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Choose Image:",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
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
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () => pickImage(),
                  child: const Text(
                    "+ Add image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Choose Banner:",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: banner != null
                        ? Image.memory(banner)
                        : const Text(
                            "Select banner",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () => pickBannerImage(),
                  child: const Text(
                    "+ Add banner",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent),
                      onPressed: () => validateForm(),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Divider(
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }
}
