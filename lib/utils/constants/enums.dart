import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'colors.dart';

/* --
      LIST OF Enums
      They cannot be created inside a class.
-- */

/// Switch of Custom Brand-Text-Size Widget

enum TransactionType { buy, sell }

enum ProductType { single, variable }

enum ProductVisibility { published, hidden }

enum TextSizes { small, medium, large }

enum ImageType { asset, network, memory, file }

enum MediaCategory { folders, banners, brands, categories, products, users }

enum OrderStatus { pending, processing, shipped, delivered, cancelled }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm
}

extension OrderStatusExtension on OrderStatus {
  Color get activeColor {
    switch (this) {
      case OrderStatus.pending:
        return Colors.blue;
      case OrderStatus.processing:
        return TColors.primary;
      case OrderStatus.shipped:
        return Colors.orange;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  IconData get icon {
    switch (this) {
      case OrderStatus.pending:
        return Iconsax.timer;
      case OrderStatus.processing:
        return Iconsax.clock;
      case OrderStatus.shipped:
        return Iconsax.ship;
      case OrderStatus.delivered:
        return Iconsax.tick_circle;
      case OrderStatus.cancelled:
        return Iconsax.close_circle;
    }
  }
}
