import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../view_model/home_provider.dart';

class ProductPage extends StatelessWidget {
  ProductItem productItem;
  ProductPage({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                child: CachedNetworkImage(imageUrl: productItem.imageUrl, fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        productItem.name,
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    Consumer<HomeProvider>(builder: (__, provider, _) {
                      return GestureDetector(
                        onTap: () => provider.setLikeClicked(productItem.id),
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: productItem.likeClicked ? Colors.red : Colors.grey,
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '฿ ${productItem.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            Provider.of<HomeProvider>(context, listen: false).addToCart(productItem);
          },
          style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.black),
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, fontFamily: 'Sarabun', height: 1.4),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add to Cart",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
