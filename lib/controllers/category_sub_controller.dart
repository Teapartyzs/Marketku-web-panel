import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_marketku/global_variables.dart';
import 'package:web_marketku/models/category_sub.dart';
import 'package:web_marketku/services/http_response.dart';

class CategorySubController {
  uploadCategorySub(
      {required context,
      required String categoryId,
      required String categoryName,
      required dynamic image,
      required String subCategoryName,
      required VoidCallback onSuccess}) async {
    try {
      final cloudinary = CloudinaryPublic("dhpriqf77", "r0gdemwm");

      CloudinaryResponse responseCloud = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(image,
            identifier: "pckdCategorySub", folder: "categorySubImages"),
      );

      String imageUrl = responseCloud.secureUrl;

      CategorySub categorySub = CategorySub(
          id: "",
          categoryId: categoryId,
          categoryName: categoryName,
          image: imageUrl,
          subCategoryName: subCategoryName);

      http.Response response = await http.post(
          Uri.parse("$url/api/categorysub"),
          body: categorySub.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });

      httpResponse(
          response: response,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CategorySub>> loadData() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$url/api/categorysub"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> dataDecode = jsonDecode(response.body);
        List<CategorySub> categorySub =
            dataDecode.map((data) => CategorySub.fromJson(data)).toList();
        return categorySub;
      } else {
        throw Exception("failed to get category data");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
