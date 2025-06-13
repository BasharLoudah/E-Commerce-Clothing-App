import 'dart:convert';

import 'package:e_commerece_app/core/common/app%20manager/app_manager_state.dart';
import 'package:e_commerece_app/core/common/constants/cache_strings.dart';
import 'package:e_commerece_app/features/home/data/models/auth_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerState());

  saveUserData(AuthResponseModel data) async {
    const storage = FlutterSecureStorage();
    final Map<String, dynamic> userData = data.toJson();
    final encodedData = jsonEncode(userData);
    await storage.write(key: CacheKeys.userData, value: encodedData);
    emit(AppManagerState(user: data));
  }

  initApp() async {
    const storage = FlutterSecureStorage();
    // Read value
    String? value = await storage.read(key: CacheKeys.userData);
    print(value);
    if (value != null) {
      final decodedData = jsonDecode(value);

      final AuthResponseModel user = AuthResponseModel.fromJson(decodedData);
      emit(state.copyWith(user: user));
      print('User token: ${user.token}');

    }
  }
}
