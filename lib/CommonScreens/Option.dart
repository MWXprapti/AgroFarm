import 'package:flutter/material.dart';
import 'package:new_app/Agro/Screens/signIn.dart';
import 'package:new_app/theme/theme.dart';

class OptionPage extends StatelessWidget {
  const OptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose an Option'),
        backgroundColor: AppColors.lightgreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPhone()),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width*0.5,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.olive,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: const Text('Farmer', style: TextStyle(fontSize: 24, color: Colors.white))),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyPhone()),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width*0.5,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(child: const Text('Manufacturer', style: TextStyle(fontSize: 24, color: Colors.white))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

