import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../models/product.dart';

final productProvider = FutureProvider.autoDispose<List<Product>>((ref) async {
  final response = await Dio().get('https://dummyjson.com/products?limit=10');
  final List data = response.data['products'];
  return data.map((e) => Product.fromJson(e)).toList();
});
