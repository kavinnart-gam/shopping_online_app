import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_online_app/view_model/home_provider.dart';

import 'home_page.dart';
import 'saved_page.dart';
import 'cart_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SavedPage(),
    CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: Center(
          child: _pages.elementAt(provider.selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.selectedIndex,
          onTap: provider.onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.houseChimney,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.heart,
              ),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.cartShopping),
              label: 'Cart',
            ),
          ],
        ),
      );
    });
  }
}
