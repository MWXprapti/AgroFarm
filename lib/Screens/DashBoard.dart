import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Screens/Home.dart';
import 'package:new_app/Screens/Product_ListingPage.dart';
import 'package:new_app/Theme/theme.dart';
import 'Product_UploadPage.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screens = [HomePage(), AddProductPage(), ProductListing(),Center(child: Text("Settings Screen"),),];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Hello, User.",style: TextStyle(color: AppColors.bgcolor,fontSize: 30),),
          backgroundColor: AppColors.lightgreen,
          shadowColor: Colors.transparent,
          // actions: [Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Icon(Icons.logout,color: AppColors.bgcolor,),
          // )],
        ),
        bottomNavigationBar: FlashyTabBar(
          backgroundColor: AppColors.bgcolor,
          selectedIndex: _selectedIndex, // Corrected type
          showElevation: true,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
            _pageController.jumpToPage(index); // Sync page change
          },
          items: [
            FlashyTabBarItem(
              activeColor:AppColors.yellow ,
              icon: const Icon(Icons.home,color: AppColors.lightgreen),
              title: const Text('Home'),
            ),
            FlashyTabBarItem(
              activeColor:AppColors.yellow ,
              icon: const Icon(Icons.search,color: AppColors.lightgreen),
              title: const Text('Search'),
            ),
            FlashyTabBarItem(
              activeColor:AppColors.yellow ,
              icon: const Icon(Icons.highlight,color: AppColors.lightgreen),
              title: const Text('Highlights'),
            ),
            FlashyTabBarItem(
              activeColor:AppColors.yellow ,
              icon: const Icon(Icons.settings,color: AppColors.lightgreen),
              title: const Text('Settings'),
            ),

          ],
        ),
        body: ClipRRect(
          child: screens[_selectedIndex],
        ),

      ),
    );
  }
}
