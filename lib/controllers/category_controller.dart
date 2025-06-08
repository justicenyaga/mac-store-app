import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mac_store_app/global_variables.dart';
import 'package:mac_store_app/models/category_model.dart';

class CategoryController {
  Future<List<Category>> loadCategories() async {
    try {
      final response =
          await http.get(Uri.parse("$uri/api/categories"), headers: {
        "Content-Type": "application/json; charset=UTF-8",
      });

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((category) => Category.fromJson(category)).toList();
      }

      throw Exception("Failed to load categories");
    } catch (e) {
      throw Exception("Error loading categories $e");
    }
  }
}
