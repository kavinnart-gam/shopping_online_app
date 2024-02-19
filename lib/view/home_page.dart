import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_online_app/view_model/home_provider.dart';

import 'widget/product_item_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // fetch data when productList is empty
    if (Provider.of<HomeProvider>(context, listen: false).productList == null) {
      Provider.of<HomeProvider>(context, listen: false).fetchData();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'For you',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        centerTitle: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
          child: Consumer<HomeProvider>(builder: (_, provider, __) {
            return provider.loading
                ? const CircularProgressIndicator(
                    color: Colors.deepPurple,
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(2, 20, 2, 20),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: provider.productList!.productItems.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                    ),
                    itemBuilder: (BuildContext ctx, int index) {
                      return ProductItemWidget(
                          productName: provider.productList!.productItems[index].name,
                          productPrice: provider.productList!.productItems[index].price,
                          imageUrl: provider.productList!.productItems[index].imageUrl,
                          context: ctx,
                          likeClicked: provider.productList!.productItems[index].likeClicked,
                          onTap: () {
                            String status = !provider.productList!.productItems[index].likeClicked ? "save" : "unsave";
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: Text('${provider.productList!.productItems[index].name} has $status'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );

                            provider.setLikeClicked(provider.productList!.productItems[index].id);
                          });
                    },
                  );
          }),
        ),
      ),
    );
  }
}
