import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Agro/Screens/FarmerToFarmer/Dash_Farmer.dart';
import 'package:new_app/Agro/Screens/Home.dart';
import 'package:new_app/Agro/Screens/agro_to_farmer/Product_ListingPage.dart';
import 'package:new_app/Agro/Screens/SalesListing.dart';
import 'package:new_app/Agro/Screens/SettingPage.dart';
import 'package:new_app/Theme/theme.dart';
import 'Product_UploadPage.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
        _pageController.jumpToPage(index);
  }
  final PageController _pageController = PageController();

  List<Widget> screens = [
    HomePage(),
    Farm_Dashboard(),
    ProductListing(),
    //SalesListPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBody: true,

          appBar: AppBar(
            title: Text("Hello, User.", style: TextStyle(color: AppColors.bgcolor, fontSize: 30)),
            backgroundColor: AppColors.lightgreen,
            shadowColor: Colors.transparent,
          ),
        // bottomNavigationBar: FlashyTabBar(
        //   backgroundColor: AppColors.bgcolor,
        //   selectedIndex: _selectedIndex,
        //   showElevation: true,
        //   onItemSelected: (index) {
        //     setState(() {
        //       _selectedIndex = index;
        //     });
        //     _pageController.jumpToPage(index);
        //   },
        //   items: [
        //     FlashyTabBarItem(
        //       activeColor: AppColors.yellow,
        //       icon: const Icon(Icons.home, color: AppColors.lightgreen),
        //       title: const Text('Home'),
        //     ),
        //     FlashyTabBarItem(
        //       activeColor: AppColors.yellow,
        //       icon: const Icon(Icons.add, color: AppColors.lightgreen),
        //       title: const Text('Add Product'),
        //     ),
        //     FlashyTabBarItem(
        //       activeColor: AppColors.yellow,
        //       icon: const Icon(Icons.list, color: AppColors.lightgreen),
        //       title: const Text('Products'),
        //     ),
        //     FlashyTabBarItem(
        //       activeColor: AppColors.yellow,
        //       icon: const Icon(Icons.featured_play_list_outlined, color: AppColors.lightgreen),
        //       title: const Text('Sales'),
        //     ),
        //     FlashyTabBarItem(
        //       activeColor: AppColors.yellow,
        //       icon: const Icon(Icons.settings, color: AppColors.lightgreen),
        //       title: const Text('Settings'),
        //     ),
        //   ],
        // ),
        bottomNavigationBar:  DotNavigationBar(
          backgroundColor: AppColors.lightgreen,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          // dotIndicatorColor: Colors.black,
          items: [
            DotNavigationBarItem(
              icon: Icon(Icons.home),
              selectedColor: Colors.amberAccent,
            ),

            DotNavigationBarItem(
              icon: Icon(Icons.add_box),
              selectedColor: Colors.amberAccent,
            ),

            DotNavigationBarItem(
              icon: Icon(CupertinoIcons.square_list),
              selectedColor: Colors.amberAccent,
            ),

            // DotNavigationBarItem(
            //   icon: Icon(CupertinoIcons.list_bullet),
            //   selectedColor: Colors.amberAccent,
            // ),
            DotNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              selectedColor: Colors.amberAccent,
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: screens,
        ),
      ),
    );
  }
}
