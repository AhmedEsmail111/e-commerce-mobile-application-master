import 'package:ecommerce/ui/home/tabs/product_list_tab/cubit/product_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ProductResponseEntity.dart';
import '../../../../../domain/use_cases/add_to_cart_use_case.dart';
import '../../../../../domain/use_cases/get_all_products_use_case.dart';

class ProductListTabViewModel extends Cubit<ProductListTabStates> {
  GetAllProductsUseCase getAllProductsUseCase;

  AddToCartUseCase addToCartUseCase;

  ProductListTabViewModel(
      {required this.getAllProductsUseCase, required this.addToCartUseCase})
      : super(ProductListTabInitialStates());

  List<ProductEntity> productsList = [];
  int numOfCartItems = 0;

  ProductEntity getProductById(String productId) =>
      productsList.firstWhere((product) => product.id == productId);

  static ProductListTabViewModel get(context) => BlocProvider.of(context);

  getProducts() async {
    emit(ProductListTabLoadingStates(loadingMessage: 'Loading...'));
    var either = await getAllProductsUseCase.invoke();
    either.fold((l) {
      emit(ProductListTabErrorStates(errors: l));
    }, (response) {
      productsList = response.data ?? [];
      print('done getting products${productsList.length}');
      emit(ProductListTabSuccessStates(productResponseEntity: response));
    });
  }
}
