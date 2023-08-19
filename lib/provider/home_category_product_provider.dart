import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/home_category_product_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/home_category_product_repo.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/product_model.dart';

class HomeCategoryProductProvider extends ChangeNotifier {
  final HomeCategoryProductRepo homeCategoryProductRepo;
  HomeCategoryProductProvider({required this.homeCategoryProductRepo});

  List<HomeCategoryProduct> _homeCategoryProductList = [];
  List<Product>? _productList;
  int _productIndex = 0;
  int get productIndex => _productIndex;
  List<HomeCategoryProduct> get homeCategoryProductList =>
      _homeCategoryProductList;
  List<Product> get productList => _productList!;

  Future<void> getHomeCategoryProductList(
      bool reload, BuildContext context) async {
    if (_homeCategoryProductList.length == 0 || reload) {
      ApiResponse apiResponse =
          await homeCategoryProductRepo.getHomeCategoryProductList();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200) {
        if (apiResponse.response!.data.toString() == '{}') {
          print('==yup====>${apiResponse.response!.data}');
        } else {
          _productList = [];
          _homeCategoryProductList.clear();
          apiResponse.response!.data.forEach((homeCategoryProduct) =>
              _homeCategoryProductList
                  .add(HomeCategoryProduct.fromJson(homeCategoryProduct)));
          _homeCategoryProductList.forEach((product) {
            _productList!.addAll(product.products!);
          });
        }
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }
}
