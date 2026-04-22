import 'package:flutter/material.dart';
import 'package:inventory_management/core/models/product.dart';
import 'package:inventory_management/core/services/api_service.dart';

class Productviewmodel extends ChangeNotifier {
  final Apiservice api;

  Productviewmodel(this.api);

  List<Product> products = [];
  bool isLoading = false;

  Future<void> fetchProducts() async {
    isLoading = true;
    notifyListeners();

    final data = await api.getProducts();
    products = data.map<Product>((e) => Product.fromJson(e)).toList();

    isLoading = false;
    notifyListeners();
  }
}