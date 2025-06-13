import 'package:e_commerece_app/features/home/data/data_source/homepage_not_this_project/RemoteCategoryDataSource.dart';
import 'package:e_commerece_app/features/home/presentation/managers/CategoryState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final RemoteCategoryDataSource remoteCategoryDataSource;

  CategoryCubit(this.remoteCategoryDataSource) : super(CategoryState());

  Future<void> fetchCategories() async {
    emit(state.copyWith(isLoading: true));
    final result = await remoteCategoryDataSource.getCategories();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure));
      },
      (categories) {
        emit(state.copyWith(isLoading: false, categories: categories));
      },
    );
  }
}
