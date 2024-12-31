import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:web_marketku/global_variables.dart';
import 'package:web_marketku/models/banner.dart';
import 'package:http/http.dart' as http;
import 'package:web_marketku/services/http_response.dart';

class BannerController {
  uploadBanner(
      {required pickImage,
      required context,
      required VoidCallback onSuccess}) async {
    try {
      final cloudinary = CloudinaryPublic("dhpriqf77", "r0gdemwm");
      CloudinaryResponse responseBanner = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickImage,
            identifier: "pckdBannerPublic", folder: "bannerPublicImages"),
      );

      String bannerUrl = responseBanner.secureUrl;

      BannerModel banner = BannerModel(id: '', image: bannerUrl);

      http.Response response = await http.post(
        Uri.parse("$url/api/banner"),
        body: banner.toJson(),
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
    } catch (e) {
      print("error uploading image to cloudinary $e");
    }
  }

  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$url/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> dataDecode = jsonDecode(response.body);
        List<BannerModel> result =
            dataDecode.map((banner) => BannerModel.fromJson(banner)).toList();
        return result;
      } else {
        throw Exception("failed to fetch data");
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
