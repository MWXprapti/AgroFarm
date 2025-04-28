import 'package:flutter/material.dart';
import 'package:new_app/Agro/Screens/auth/signIn.dart';
import 'package:new_app/Theme/theme.dart';


class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  final List<Map<String, String>> pages = [
    {
      'image': 'assets/agro1.jpg',
      'title1': 'Welcome to AgroFarm',
      'title2': 'Empowering Agriculture Digitally',
      'description': "AgroFarm is your digital companion for smarter farming. Connect with agro businesses, manufacturers, and fellow farmers to grow together."
    },
    {
      'image': 'assets/agro2.jpg',
      'title1': 'Seamless Communication',
      'title2': 'Between Farmers and Businesses',
      'description': "Stay connected without interruptions. AgroFarm ensures smooth communication and collaboration across the agricultural ecosystem."
    },
    {
      'image': 'assets/agro3.jpg',
      'title1': 'Smart Management Tools',
      'title2': 'For Better Productivity',
      'description': "Organize, manage, and accomplish your agricultural goals efficiently with AgroFarm's innovative tools."
    },
    {
      'image': 'assets/agro4.jpg',
      'title1': 'Experience Innovation',
      'title2': 'At Your Fingertips',
      'description': "Enjoy cutting-edge features designed to simplify farming and enhance your agricultural experience."
    }
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pages.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: currentPage == index ? 12 : 8,
                    height: currentPage == index ? 12 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage == index ? AppColors.olive : Colors.grey,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 25),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.olive,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  PhoneVerificationScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: PageView.builder(
          itemCount: pages.length,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(pages[index]['image']!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      pages[index]['title1']!,
                      style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      pages[index]['title2']!,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        pages[index]['description']!,
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
