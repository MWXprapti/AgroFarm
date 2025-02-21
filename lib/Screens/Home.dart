import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_app/Controllers/Product_Controller.dart';
import 'package:new_app/Theme/theme.dart';
import 'package:get/get.dart';

class DrinkCardPageGrid extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30,
          childAspectRatio: 0.8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed("product");
                  },
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 10,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('White Chocolate Cappuccino', style: TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('', style: TextStyle(color: Colors.black54, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -35,
                left: 40,
                child: Image.asset(
                  'assets/fertilizer.png',
                  height: 170,
                  fit: BoxFit.contain,
                ),
              ),
              // Positioned(
              //   top: 40,
              //   left: 15,
              //   child: Row(
              //     children: [
              //       Icon(Icons.star, color: Colors.yellow, size: 18),
              //       SizedBox(width: 4),
              //       Text('7.8', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
              //     ],
              //   ),
              // ),
              Positioned(
                bottom: 20,
                right: 7,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: Icon(Icons.favorite_border, color: Colors.red),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

 bool fav = false;
class _HomePageState extends State<HomePage> {
  final List<String> offers = [
    'assets/agri1.jpg',
    'assets/agri2.jpg',
    'assets/agri3.jpg',
    'assets/agri4.jpg',
    'assets/agri5.jpg',
  ];

  final List<String> catagories = [
    "Herbicides",
    "Growth\nPromoters",
    "fungicides",
    "Vegetable & \nFruits seeds",
    "Farm \nMachinery",
    "Nutrients",
    "Flower \nseeds",
    "Insecticides",
    "Organic \nfarming",
    "Animal \nhusbandry",
  ];
  final List<String> cata_icon = [
    'assets/herbicide.png',
    'assets/growth.png',
    'assets/fungicides.png',
    'assets/seeds.png',
    'assets/machine.png',
    'assets/nutrient.png',
    'assets/flower.png',
    'assets/insect.png',
    'assets/organic.png',
    'assets/animal.png',
  ];

  // Declare a CarouselController from carousel_slider package
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SingleChildScrollView( // Wrap the entire body inside SingleChildScrollView
        child: Column(
          children: [
            // Header Container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(4, 4),
                  ),
                ],
                color: AppColors.lightgreen,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),

                ),
              ),
              child: Row(
                children: [
                  //location
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8,top: 13,bottom: 13),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: Colors.red,),
                          Text("Location",)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  // Search Bar Container
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Search",
                          labelStyle: TextStyle(color: Colors.grey),
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: AppColors.lightgreen),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  //SizedBox(width: 12), // Space between search field & button
                  // IconButton Outside the Search Bar
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     shape: BoxShape.circle,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black26,
                  //         blurRadius: 8,
                  //         offset: Offset(4, 4),
                  //       ),
                  //     ],
                  //   ),
                  //   child: IconButton(
                  //     icon: Icon(Icons.mic, color: AppColors.lightgreen),
                  //     onPressed: () {
                  //       // Implement voice search or any other action
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10,bottom: 15),
                  child: Text("Special offers",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            // CarouselSlider
            CarouselSlider(
              items: offers.map((offer) {
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(offer),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 180,
                viewportFraction: 0.9,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) => setState(() => _current = index),
              ),
              carouselController: _controller,
            ),

            SizedBox(height: 10),

            // Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: offers.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.grey)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),

            // Categories List
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.15,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: cata_icon.length, // Use the length of cata_icon list
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10), // Add padding for better spacing
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                cata_icon[index], // Accessing the correct image path
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          catagories[index], // Display category name
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Recommended for you",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Spacer(),
                  Text("See All",style: TextStyle(color: AppColors.yellow,fontSize: 20),)
                ],
              ),
            ),
            SizedBox(height: 20,),
            DrinkCardPageGrid(),
          ],
        ),
      ),
    );
  }
}
