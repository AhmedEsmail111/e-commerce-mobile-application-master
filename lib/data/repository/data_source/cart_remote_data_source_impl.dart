import 'package:dartz/dartz.dart';
import 'package:ecommerce/data/model/response/GetCartResponseDto.dart';

import '../../../domain/entities/failures.dart';
import '../../../domain/repository/data_source/cart_remote_data_source.dart';
import '../../api/api_manager.dart';

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  ApiManager apiManager;
  CartRemoteDataSourceImpl({required this.apiManager});
  @override
  Future<Either<Failures, CartResponseModel>> getCart() async {
    var either = await apiManager.getCart();
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failures, CartResponseModel>> deleteItemInCart(
      String productId) async {
    var either = await apiManager.deleteItemInCart(productId);
    return either.fold((l) {
      return Left(Failures(errorMessage: l.errorMessage));
    }, (response) {
      return Right(response);
    });
  }

  // @override
  // Future<Either<Failures, GetCartResponseEntity>> updateCountInCart
  //     (String productId,int count)async {
  //   var either = await apiManager.updateCountInCart(productId,count);
  //   return either.fold((l) {
  //     return Left(Failures(errorMessage: l.errorMessage));
  //   }, (response) {
  //     return Right(response);
  //   });
  // }
}
