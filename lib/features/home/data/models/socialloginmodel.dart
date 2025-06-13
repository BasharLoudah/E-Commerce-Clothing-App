import 'dart:ui';

import 'package:e_commerece_app/core/style/assets/app_assets.dart';

class socialloginmodel {
  final String name;
  final String iconAsset;
  final VoidCallback onTap;
  socialloginmodel({
    required this.name,
    required this.iconAsset,
    required this.onTap, 
  });

  static List<socialloginmodel> loginwith = [
    socialloginmodel(
        name: 'Continue With Apple', iconAsset: AppAssets.apple, onTap: () {}),
    socialloginmodel(
        name: 'Continue With Google',
        iconAsset: AppAssets.google,
        onTap: () {}),
    socialloginmodel(
        name: 'Continue With Facebook',
        iconAsset: AppAssets.facebook,
        onTap: () {}),
  ];
}