import 'package:e_commerece_app/features/home/data/data_source/homepage_not_this_project/homepage_not_thisproject_remoteProductDataSource.dart';
import 'package:e_commerece_app/features/home/presentation/managers/CategoryState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productcubit extends Cubit<CategoryState> {
  final RemoteProductDataSource remoteProductDataSource;

  Productcubit(this.remoteProductDataSource) : super(CategoryState());

  Future<void> fetchProdcuts() async {
    emit(state.copyWith(isLoading: true));
    final result = await remoteProductDataSource.getProduct();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure));
      },
      (products) {
        emit(state.copyWith(isLoading: false, products: products));
      },
    );
  }
}
