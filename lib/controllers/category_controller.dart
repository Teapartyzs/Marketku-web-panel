import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:web_marketku/global_variables.dart';
import 'package:web_marketku/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:web_marketku/services/http_response.dart';

class CategoryController {
  uploadCategory(
      {required context,
      required String name,
      required dynamic pickImage,
      required dynamic pickBanner,
      required VoidCallback onSuccess}) async {
    try {
      final cloudinary = CloudinaryPublic("dhpriqf77", "r0gdemwm");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickImage,
            identifier: "pckdImage", folder: "categoryImages"),
      );
      String imageUrl = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickBanner,
            identifier: "pckdBanner", folder: "bannerImages"),
      );
      String bannerUrl = bannerResponse.secureUrl;

      Category category =
          Category(id: "", name: name, image: imageUrl, banner: bannerUrl);

      http.Response response = await http.post(
        Uri.parse("$url/api/add-category"),
        body: category.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      httpResponse(
        response: response,
        context: context,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Add category success"),
              duration: Duration(seconds: 2), // Durasi toast
            ),
          );
          onSuccess();
        },
      );
    } catch (error) {
      print("error uploading image to cloudinary $error");
    }
  }

  Future<List<Category>> loadCategory() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$url/api/category'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> dataDecode = jsonDecode(response.body);
        List<Category> result =
            dataDecode.map((category) => Category.fromJson(category)).toList();
        return result;
      } else {
        throw Exception("failed to get category data");
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
