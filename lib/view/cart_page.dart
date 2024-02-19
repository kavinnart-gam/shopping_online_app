import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_online_app/view/checkout_page.dart';

import '../view_model/home_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Consumer<HomeProvider>(builder: (_, provider, __) {
          return Column(
            children: [
              SlidableAutoCloseBehavior(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: provider.productCartList.length,
                    padding: const EdgeInsets.all(20),
                    itemBuilder: (context, index) {
                      return Slidable(
                          key: ValueKey(provider.productCartList[index].id),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            extentRatio: 0.27,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  provider.removeCartProduct(provider.productCartList[index].id);
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.black,
                                icon: FontAwesomeIcons.trash,
                                label: '',
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(0, 1),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CachedNetworkImage(
                                    imageUrl: provider.productCartList[index].imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(provider.productCartList[index].name),
                                        Text(
                                          '฿ ${provider.productCartList[index].price.toStringAsFixed(2)}',
                                        ),
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(color: Colors.black, width: 1.0)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(color: Colors.black, width: 1.0), // Border on the right side
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    child: const Text("-"),
                                                    onPressed: () => provider.decreseProduct(provider.productCartList[index].id),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  provider.productCartList[index].amount.toString(),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(color: Colors.black, width: 1.0), // Border on the right side
                                                    ),
                                                  ),
                                                  child: TextButton(
                                                    child: const Text("+"),
                                                    onPressed: () => provider.increaseProduct(provider.productCartList[index].id),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total: \$${provider.getTotalPrice()}"),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckoutPage(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Sarabun', height: 1.4),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Checkout",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
