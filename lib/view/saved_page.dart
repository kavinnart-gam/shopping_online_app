import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_online_app/view/product_page.dart';
import '../view_model/home_provider.dart';
import 'widget/product_item_widget.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Saved',
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          centerTitle: false,
        ),
        body: Consumer<HomeProvider>(builder: (_, provider, __) {
          return Container(
              padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(2, 20, 2, 20),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: provider.productSelected.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                ),
                itemBuilder: (BuildContext ctx, int index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            productItem: provider.productSelected[index],
                          ),
                        )),
                    child: ProductItemWidget(
                        productName: provider.productSelected[index].name,
                        productPrice: provider.productSelected[index].price,
                        imageUrl: provider.productSelected[index].imageUrl,
                        context: ctx,
                        likeClicked: provider.productSelected[index].likeClicked,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: Text('${provider.productSelected[index].name} has unsave'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'OK');
                                    provider.setLikeClicked(provider.productSelected[index].id);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }),
                  );
                },
              ));
        }));
  }
}
