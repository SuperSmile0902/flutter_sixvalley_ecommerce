import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/response/transaction_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/wallet_transaction_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/product_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/wallet/widget/transaction_widget.dart';
import 'package:provider/provider.dart';

class TransactionListView extends StatelessWidget {
  final ScrollController? scrollController;
  TransactionListView({this.scrollController});

  @override
  Widget build(BuildContext context) {
    int offset = 1;
    scrollController?.addListener(() {
      if (scrollController!.position.maxScrollExtent ==
              scrollController!.position.pixels &&
          Provider.of<WalletTransactionProvider>(context, listen: false)
                  .transactionList
                  .length !=
              0 &&
          !Provider.of<WalletTransactionProvider>(context, listen: false)
              .isLoading) {
        int pageSize;
        pageSize =
            Provider.of<WalletTransactionProvider>(context, listen: false)
                .transactionPageSize;

        if (offset < pageSize) {
          offset++;
          print('end of the page');
          Provider.of<WalletTransactionProvider>(context, listen: false)
              .showBottomLoader();
          Provider.of<WalletTransactionProvider>(context, listen: false)
              .getTransactionList(context, offset, reload: false);
        }
      }
    });

    return Consumer<WalletTransactionProvider>(
      builder: (context, transactionProvider, child) {
        List<WalletTransactioList> transactionList;
        transactionList = transactionProvider.transactionList;

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: Dimensions.PADDING_SIZE_LARGE,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.HOME_PAGE_PADDING,
                right: Dimensions.HOME_PAGE_PADDING),
            child: Text(
              '${getTranslated('transaction_history', context)}',
              style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE),
            ),
          ),
          !transactionProvider.firstLoading
              ? (transactionList != null && transactionList.length != 0)
                  ? Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: transactionList.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                                width: (MediaQuery.of(context).size.width / 2) -
                                    20,
                                child: TransactionWidget(
                                    transactionModel: transactionList[index]));
                          }),
                    )
                  : SizedBox.shrink()
              : ProductShimmer(
                  isHomePage: true,
                  isEnabled: transactionProvider.firstLoading),
          transactionProvider.isLoading
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.all(Dimensions.ICON_SIZE_EXTRA_SMALL),
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor)),
                ))
              : SizedBox.shrink(),
        ]);
      },
    );
  }
}
