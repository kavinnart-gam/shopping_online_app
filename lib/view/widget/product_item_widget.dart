import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductItemWidget extends StatelessWidget {
  String productName;
  double productPrice;
  String imageUrl;
  BuildContext context;
  Function onTap;
  bool likeClicked;

  ProductItemWidget(
      {Key? key,
      required this.productName,
      required this.productPrice,
      required this.imageUrl,
      required this.context,
      required this.onTap,
      required this.likeClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 1),
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.1,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              GestureDetector(
                onTap: () => onTap(),
                child: Icon(
                  FontAwesomeIcons.solidHeart,
                  color: likeClicked ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(productName),
              Text(
                '฿ ${productPrice.toStringAsFixed(2)}',
              )
            ],
          )
        ],
      ),
    );
  }
}
