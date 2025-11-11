import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

bool isArabic(BuildContext context) {
  return context.locale.languageCode == 'ar';
}

// isArabic(context);

extension LocaleExtension on BuildContext {
  bool get isArabic => locale.languageCode == 'ar';
}

// SizedBix(height:10)
// 12.4.h,

extension SizedBix on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toTitleCase() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

var dd = "dskfjsd".isEmpty;
