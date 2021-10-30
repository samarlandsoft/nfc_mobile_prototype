import 'package:flutter/material.dart';
import 'package:nfc_mobile_prototype/features/marketplace/domain/models/product.dart';

class DetailsProduct {
  final Product product;
  final List<Color> gradient;

  const DetailsProduct({
    required this.product,
    required this.gradient,
  });
}
