import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/banner_model.dart';

class BannerController {
  // fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      final response = await http.get(
        Uri.parse("$uri/api/banner"),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        return data.map((banner) => BannerModel.fromJson(banner)).toList();
      }

      throw Exception("Failed to load banners.");
    } catch (e) {
      throw Exception("Error loading banners $e");
    }
  }
}
