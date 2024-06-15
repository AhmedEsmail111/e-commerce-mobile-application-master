import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/consts.dart';
import 'package:ecommerce/data/model/response/handle_wislist_response.dart';
import 'package:http/http.dart' as http;

import '../../core/utils/shared_preference_utils.dart';
import '../../domain/entities/failures.dart';
import '../model/request/LoginRequest.dart';
import '../model/request/RegisterRequest.dart';
import '../model/response/AddToCartResponseDto.dart';
import '../model/response/CategoryOrBrandResponseDto.dart';
import '../model/response/GetCartResponseDto.dart';
import '../model/response/LoginResponseDto.dart';
import '../model/response/ProductResponseDto.dart';
import '../model/response/RegisterResponseDto.dart';
import 'api_constants.dart';

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;

  static ApiManager getInstance() {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<Either<Failures, RegisterResponseDto>> register(String name,
      String email, String password, String rePassword, String phone) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      Uri url = Uri.parse("${Apiconstants.baseUrl}${Apiconstants.registerApi}");
      var requestBody = RegisterRequest(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone,
      );
      var response = await http.post(url, body: requestBody.toJson());
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var registerResponse = RegisterResponseDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        SharedPreferenceUtils.saveData(
            key: kTokenKey, value: registerResponse.token);

        return Right(registerResponse);
      } else {
        return Left(Failures(
            errorMessage: registerResponse.error != null
                ? registerResponse.error!.msg
                : registerResponse.message));
      }
    } else {
      /// no internet connection
      return Left(Failures(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, LoginResponseDto>> login(
    String email,
    String password,
  ) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      Uri url = Uri.parse("${Apiconstants.baseUrl}${Apiconstants.loginApi}");
      var requestBody = LoginRequest(email: email, password: password);

      var response = await http.post(url, body: requestBody.toJson());
      print(response.body);
      var responseBody = response.body;

      var json = jsonDecode(responseBody);
      var loginResponse = LoginResponseDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        SharedPreferenceUtils.saveData(
            key: kTokenKey, value: loginResponse.token);
        return Right(loginResponse);
      } else {
        return Left(Failures(errorMessage: loginResponse.message));
      }
    } else {
      /// no internet connection
      return Left(Failures(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, CategoryOrBrandResponseDto>>
      getAllCategories() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      Uri url = Uri.parse(
          '${Apiconstants.baseUrl}${Apiconstants.getAllCategoriesApi}');
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var categoryResponse = CategoryOrBrandResponseDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(categoryResponse);
      } else {
        return Left(Failures(errorMessage: categoryResponse.message));
      }
    } else {
      /// no internet connection
      return Left(Failures(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, CategoryOrBrandResponseDto>> getAllBrands() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      Uri url =
          Uri.parse('${Apiconstants.baseUrl}${Apiconstants.getAllBrandsApi}');
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var categoryOrBrandResponse = CategoryOrBrandResponseDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(categoryOrBrandResponse);
      } else {
        return Left(ServerError(errorMessage: categoryOrBrandResponse.message));
      }
    } else {
      /// no internet connection
      return Left(NetworkError(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, ProductResponseDto>> getAllProducts() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      Uri url =
          Uri.parse('${Apiconstants.baseUrl}${Apiconstants.getAllProductsApi}');
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var productResponse = ProductResponseDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(productResponse);
      } else {
        return Left(ServerError(errorMessage: productResponse.message));
      }
    } else {
      /// no internet connection
      return Left(NetworkError(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, AddToCartResponseDto>> addToCart(
      String productId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      var token = SharedPreferenceUtils.getData(key: kTokenKey);
      print(token);
      Uri url =
          Uri.parse('${Apiconstants.baseUrl}${Apiconstants.addToCartApi}');
      var response = await http.post(url, body: {
        'product': productId
      }, headers: {
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjY3MmM1OThlZjI0YjQyMmZiZjQxMDMiLCJyb2xlIjoidXNlciIsImlhdCI6MTcxODAzNzU5M30.z_uG7H4hdE37tWGNv10SI0ZusypphAED0R7ltuhsmFQ',
      });
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var addToCartResponse = AddToCartResponseDto.fromJson(json);
      if (response.statusCode == 200) {
        print(response.body);
        return Right(addToCartResponse);
      } else if (response.statusCode == 401) {
        print(response.body);
        return Left(ServerError(errorMessage: addToCartResponse.message));
      } else {
        print(response.body);
        return Left(ServerError(errorMessage: addToCartResponse.message));
      }
    } else {
      /// no internet connection
      return Left(NetworkError(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, CartResponseModel>> getCart() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      var token = SharedPreferenceUtils.getData(key: kTokenKey);
      Uri url = Uri.parse('${Apiconstants.baseUrl}${Apiconstants.getCartApi}');
      var response = await http.get(url, headers: {
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjY3MmM1OThlZjI0YjQyMmZiZjQxMDMiLCJyb2xlIjoidXNlciIsImlhdCI6MTcxODAzNzU5M30.z_uG7H4hdE37tWGNv10SI0ZusypphAED0R7ltuhsmFQ',
      });
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var getCartResponse = CartResponseModel.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(getCartResponse);
      } else if (response.statusCode == 401) {
        return Left(ServerError(errorMessage: getCartResponse.message));
      } else {
        return Left(ServerError(errorMessage: getCartResponse.message));
      }
    } else {
      /// no internet connection
      return Left(NetworkError(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, CartResponseModel>> deleteItemInCart(
      String productId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      var token = SharedPreferenceUtils.getData(key: kTokenKey);
      Uri url = Uri.parse(
          '${Apiconstants.baseUrl}${Apiconstants.removeFromCartApi}/$productId');
      var response = await http.delete(url, headers: {
        'token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjY3MmM1OThlZjI0YjQyMmZiZjQxMDMiLCJyb2xlIjoidXNlciIsImlhdCI6MTcxODAzNzU5M30.z_uG7H4hdE37tWGNv10SI0ZusypphAED0R7ltuhsmFQ',
      });
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var deleteCartResponse = CartResponseModel.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(deleteCartResponse);
      } else if (response.statusCode == 401) {
        return Left(ServerError(errorMessage: deleteCartResponse.message));
      } else {
        return Left(ServerError(errorMessage: deleteCartResponse.message));
      }
    } else {
      /// no internet connection
      return Left(NetworkError(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, ProductDto>> getSpecificProduct(
      String productId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      Uri url = Uri.parse(
          '${Apiconstants.baseUrl}${Apiconstants.getAllProductsApi}/$productId');
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      var productResponse = ProductDto.fromJson(json);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(productResponse);
      } else {
        return Left(ServerError(errorMessage: 'error'));
      }
    } else {
      /// no internet connection
      return Left(NetworkError(errorMessage: 'Check Internet connection'));
    }
  }

  Future<Either<Failures, HandleWishlistAddRemoveResponseModel>>
      handleWishListAddandRemove(String productId) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi .
      Uri url =
          Uri.parse('${Apiconstants.baseUrl}${Apiconstants.handleWishListApi}');
      var response = await http.post(
        url,
        body: {
          'product': productId,
        },
        headers: {
          'token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NjY3MmM1OThlZjI0YjQyMmZiZjQxMDMiLCJyb2xlIjoidXNlciIsImlhdCI6MTcxODAzNzU5M30.z_uG7H4hdE37tWGNv10SI0ZusypphAED0R7ltuhsmFQ',
          ''
              'Content-Type': 'application/json'
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        var responseBody = response.body;
        var json = jsonDecode(responseBody);
        var productResponse =
            HandleWishlistAddRemoveResponseModel.fromJson(json);
        return Right(productResponse);
      } else {
        print(response.body);
        return Left(ServerError(errorMessage: 'error'));
      }
    } else {
      /// no internet connection
      return Left(NetworkError(errorMessage: 'Check Internet connection'));
    }
  }

  // Future<Either<Failures, GetCartResponseDto>> updateCountInCart(
  //     String productId, int count) async {
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi) {
  //     // I am connected to a mobile network or wifi .
  //     var token = SharedPreferenceUtils.getData(key: 'Token');
  //     Uri url = Uri.https(
  //         Apiconstants.baseUrl, '${Apiconstants.addToCartApi}/$productId');
  //     var response = await http.put(url,
  //         headers: {'token': token.toString()}, body: {'count': '$count'});
  //     var responseBody = response.body;
  //     var json = jsonDecode(responseBody);
  //     var updateCartResponse = GetCartResponseDto.fromJson(json);
  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       return Right(updateCartResponse);
  //     } else if (response.statusCode == 401) {
  //       return Left(ServerError(errorMessage: updateCartResponse.message));
  //     } else {
  //       return Left(ServerError(errorMessage: updateCartResponse.message));
  //     }
  //   } else {
  //     /// no internet connection
  //     return Left(NetworkError(errorMessage: 'Check Internet connection'));
  //   }
  // }
}