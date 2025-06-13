import 'package:e_commerece_app/features/home/data/data_source/homepage_not_this_project/homepage_not_thisproject_categoryremoteDataSource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/catmodel.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  CategoryLoaded(this.categories);
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRemoteDataSource dataSource;

  CategoryCubit(this.dataSource) : super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    try {
      final categories = await dataSource.fetchCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
