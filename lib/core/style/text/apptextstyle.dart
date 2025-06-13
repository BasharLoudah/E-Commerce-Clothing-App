import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle white15 = const TextStyle(
    fontFamily: 'circular',
    color: Colors.white,
    fontSize: 15,
  );
  static TextStyle white15BOld = const TextStyle(
    fontFamily: 'circular',
    color: Colors.white,
    fontWeight:FontWeight.bold,
    fontSize: 15,
  );
  static TextStyle black16BOld = const TextStyle(
      fontFamily: 'circular', fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle white16 = const TextStyle(
    fontFamily: 'circular',
    color: Colors.white,
    fontSize: 16,
  );
  static TextStyle black16w500 = const TextStyle(
    fontFamily: 'circular',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static TextStyle black16w05 = const TextStyle(
    fontFamily: 'circular',
    fontSize: 16,
    color: Color.fromRGBO(36, 35, 35, 0.5),
    fontWeight: FontWeight.w500,
  );

  static TextStyle black12w500 = const TextStyle(
    fontFamily: 'circular',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static TextStyle black12w700 = const TextStyle(
    fontFamily: 'circular',
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Color.fromRGBO(39, 39, 39, 1),
  );

  static TextStyle black12lineThrough = const TextStyle(
    fontFamily: 'circular',
    decoration: TextDecoration.lineThrough,
    color: Color.fromRGBO(39, 39, 39, 0.5),
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static TextStyle black32Login = const TextStyle(
    fontFamily: 'circular',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );
  static TextStyle black24w500 = const TextStyle(
    fontFamily: 'circular',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: Color.fromRGBO(39, 39, 39, 1),
  );
}
