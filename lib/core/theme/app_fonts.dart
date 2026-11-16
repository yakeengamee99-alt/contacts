import 'package:contact_assignment/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';

TextStyle titleLarge({double? size, FontWeight? weight, Color? colors}) {
  return TextStyle(
    fontSize: size ?? 20,
    fontWeight: weight ?? .bold,
    color: colors ?? AppColors.gold,
  );
}

TextStyle titleMedium({double? size, FontWeight? weight, Color? colors}) {
  return TextStyle(
    fontSize: size ?? 16,
    fontWeight: weight ?? .bold,
    color: colors ?? AppColors.gold,
  );
}

TextStyle bodySmall({double? size, FontWeight? weight, Color? colors}) {
  return TextStyle(
    fontSize: size ?? 10,
    fontWeight: weight ?? .normal,
    color: colors ?? AppColors.gold,
  );
}
