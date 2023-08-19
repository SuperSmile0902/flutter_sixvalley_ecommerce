import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/base/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/top_seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/data/repository/top_seller_repo.dart';
import 'package:flutter_sixvalley_ecommerce/helper/api_checker.dart';

class TopSellerProvider extends ChangeNotifier {
  final TopSellerRepo topSellerRepo;

  TopSellerProvider({required this.topSellerRepo});

  List<TopSellerModel> _topSellerList = [];
  int _topSellerSelectedIndex = 0;

  List<TopSellerModel> get topSellerList => _topSellerList;
  int get topSellerSelectedIndex => _topSellerSelectedIndex;

  Future<void> getTopSellerList(bool reload, BuildContext context) async {
    if (_topSellerList.length == 0 || reload) {
      ApiResponse apiResponse = await topSellerRepo.getTopSeller();
      if (apiResponse.response != null &&
          apiResponse.response!.statusCode == 200 &&
          apiResponse.response!.data.toString() != '{}') {
        _topSellerList.clear();
        apiResponse.response!.data.forEach((category) =>
            _topSellerList.add(TopSellerModel.fromJson(category)));
        _topSellerSelectedIndex = 0;
      } else {
        ApiChecker.checkApi(context, apiResponse);
      }
      notifyListeners();
    }
  }

  void changeSelectedIndex(int selectedIndex) {
    _topSellerSelectedIndex = selectedIndex;
    notifyListeners();
  }
}
