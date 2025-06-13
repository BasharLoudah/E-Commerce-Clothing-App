import 'package:dartz/dartz.dart';
import 'package:e_commerece_app/features/home/data/data_source/product_remote_data_source.dart';
import 'package:e_commerece_app/features/home/presentation/managers/Auth/productstate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRemoteDataSource dataSource;

  ProductCubit({required this.dataSource}) : super(ProductState());


Future<void> uploadProduct(CreateProductParams params) async {
  emit(state.copyWith(isLoading: true));
  try {
    print("uploadProduct started");
    final response = await dataSource.addProduct(params);
    response.fold(
      (error) {
        print("uploadProduct failed with error: $error");
        emit(state.copyWith(isLoading: false, error: error));
      },
      (productData) {
        print("uploadProduct succeeded");
        emit(state.copyWith(isLoading: false, productData: productData));
      },
    );
  } catch (e) {
    print("uploadProduct exception: $e");
    emit(state.copyWith(isLoading: false, error: e.toString()));
  }
}

Future<Either<String, List<Map<String, dynamic>>>> fetchCategories() async {
    emit(state.copyWith(isLoadingCategories: true, errorCategories: null));
    try {
      print("fetchCategories started");
      final response = await dataSource.fetchCategories();
      response.fold(
        (error) {
          print("fetchCategories failed with error: $error");
          emit(state.copyWith(
            isLoadingCategories: false,
            errorCategories: error,
          ));
          return Left(error);
        },
        (categories) {
          print("fetchCategories succeeded");
          emit(state.copyWith(
            isLoadingCategories: false,
            categories: categories,
          ));
          return Right(categories);
        },
      );
      return response; // Return the Either response
    } catch (e) {
      print("fetchCategories exception: $e");
      final error = e.toString();
      emit(state.copyWith(
        isLoadingCategories: false,
        errorCategories: error,
      ));
      return Left(error);
    }
  }
  }